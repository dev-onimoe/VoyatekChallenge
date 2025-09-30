//
//  Observable.swift
//  VoyatekChallenge
//
//  Created by FMY-762 on 30/09/2025.
//

import Foundation

final class Observable<T> {
    
    var value : T {
        didSet {
            listener?(value)
        }
    }
    private var listener : ((T) -> Void)?
    
    init (_ value : T) {
        self.value = value
    }
    
    func bind(completion : @escaping (T) -> Void) {
        
        completion(value)
        listener = completion
    }
}
