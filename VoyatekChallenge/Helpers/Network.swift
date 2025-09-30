//
//  Network.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 30/09/2025.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    func callApi(_ strApiName: String,
                 param: [String: Any]?,
                 method: String, // "GET", "POST", "PUT", "DELETE"
                 header: [String: String]? = nil,
                 encoding: String = "application/x-www-form-urlencoded",
                 isWholeJson: Bool = false,
                 jsonData: Data? = nil,
                 completionHandler: @escaping (Result<[String: Any], Error>) -> Void) {
        
        let urlString = "\(baseUrl)\(strApiName)"
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL: \(urlString)")
            completionHandler(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        print("➡️ API Request: \(method) \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        // Set headers
        header?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Encode body depending on JSON vs form
        if let jsonData = jsonData {
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } else if let params = param {
            if isWholeJson {
                do {
                    let data = try JSONSerialization.data(withJSONObject: params, options: [])
                    request.httpBody = data
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    print("❌ JSON serialization error: \(error.localizedDescription)")
                    completionHandler(.failure(error))
                    return
                }
            } else {
                let query = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                request.httpBody = query.data(using: .utf8)
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
                completionHandler(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Invalid response")
                completionHandler(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                return
            }
            
            print("📡 Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("❌ Server returned error status: \(httpResponse.statusCode)")
                completionHandler(.failure(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                completionHandler(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            if let rawString = String(data: data, encoding: .utf8) {
                print("📥 Raw Response String: \(rawString)")
            }

            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("✅ Response JSON: \(jsonObject)")
                    completionHandler(.success(jsonObject))
                } else {
                    print("❌ Failed to parse JSON")
                    completionHandler(.failure(NSError(domain: "JSONError", code: 0, userInfo: nil)))
                }
            } catch {
                print("❌ JSON parsing error: \(error.localizedDescription)")
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
