//
//  RxAlamofire+Extensions.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/13.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            let responseTuple = data as? (HTTPURLResponse, Data)
            
            guard let jsonData = responseTuple?.1 else {
                throw NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
                )
            }
            
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: jsonData)
            
            return Observable.just(object)
        }
    }
}
