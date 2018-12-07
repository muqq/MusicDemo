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
    
    func getCateogries() -> Observable<[Category]>
    func getCateogry(id: String) -> Observable<CategoryDetail>
    //func getPlaylists() -> Observable<PlayList>
}


class API: APIService {

    
    

    private let APIID = "aaa496e0ea4f2bfb2beb899384f048f6"
    private let secret = "6a383b62e769cce6fdca9f736fde87cd"
    private let path = "https://api.kkbox.com/v1.1/"
    private let tail = "?territory=TW&offset=0&limit=500"
    private var token: String?
    
    internal func sendRequest<T: Codable>(path: String, method: HTTPMethod) -> Single<T> {
        return Single<T>.create(subscribe: { single -> Disposable in
            guard let token = self.token else {
                single(.error(KKDEMOError.noToken))
                return Disposables.create()
            }
            let url = URL(string: self.path + path + self.tail)!
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "authorization": "Bearer \(token)"
            ]
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data else {
                        single(.error(KKDEMOError.noData))
                        return
                    }
                    
                    
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        print("回傳json = \(json)")
                        let responseItem = try JSONDecoder().decode(T.self, from: data)
                        single(.success(responseItem))
                    } catch {
                        single(.error(KKDEMOError.decodeError))
                    }
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        })
        
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
                    guard let data = data else {
                        single(.error(KKDEMOError.noToken))
                        return
                    }
                    let dict: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
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
    case decodeError
    case noData
}

enum Path: String {
    case newReleaseCategories = "featured-playlist-categories"
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
