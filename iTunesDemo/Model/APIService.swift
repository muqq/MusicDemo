//
//  APIManager.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/4.
//  Copyright © 2018 n1. All rights reserved.
//

import RxSwift

protocol APIService {
    func getToken() -> Single<String>
}

class API: APIService {
    
    private let APIID = "aaa496e0ea4f2bfb2beb899384f048f6"
    private let secret = "6a383b62e769cce6fdca9f736fde87cd"
    private let path = "https://api.kkbox.com/v1.1/"
    private var token: String?
    
    private func sendRequest() {
        guard let url = URL(string: path + Path.newReleaseCategories.rawValue) else {
            return
        }
        var request = URLRequest(url: url)
        let auth = "\(APIID):\(secret)".data(using: .utf8)!.base64EncodedString()
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(auth)"
        ]
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        }
        task.resume()
    }
    
    func getToken() -> Single<String> {
        return Single<String>.create(subscribe: { [weak self] single -> Disposable in
            let url = URL(string: "https://account.kkbox.com/oauth2/token")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let body = "grant_type=client_credentials"
            let bodyData = body.data(using: .utf8)
            request.httpBody = bodyData
            let auth = "\(self!.APIID):\(self!.secret)".data(using: .utf8)!.base64EncodedString()
            request.allHTTPHeaderFields = [
                "Authorization": "Basic \(auth)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    let dict: [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
                    guard let token = dict["access_token"] as? String else {
                        single(.error(KKDEMOError.noToken))
                        return
                    }
                    self?.token = token
                    single(.success(token))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        })
    }
}

enum KKDEMOError: Error {
    case noToken
}

enum Path: String {
    case newReleaseCategories = "new-release-categories"
}
