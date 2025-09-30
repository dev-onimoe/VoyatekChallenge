//
//  ViewModel.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 30/09/2025.
//

import Foundation

class ViewModel {
    var responseObserver : Observable<Response?> = Observable(nil)
    
    func createTrip<T: Decodable>(
        param: [String: Any],
        as type: T.Type
    ) {
        ApiManager.shared.callApi("/api/create-trip", param: param, method: "POST") { result in
            switch result {
            case .success(let response):
                if let responseData = response["data"] as? [String: Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseData, options: [])
                        
                        let decoded = try JSONDecoder().decode(T.self, from: jsonData)
                        self.responseObserver.value = Response(successful: true, object: decoded)
                    } catch {
                        self.responseObserver.value = Response(successful: false, message: error.localizedDescription)
                    }
                } else {
                    self.responseObserver.value = Response(successful: false, message: "Invalid response")
                }
            case .failure(let error):
                self.responseObserver.value = Response(successful: false, message: error.localizedDescription)
            }
        }
    }
}
