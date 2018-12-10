//
//  APIService+PlayList.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/10.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RxSwift

extension API {
    func getPlaylists() -> Observable<[PlayList]> {
        return Observable<[PlayList]>.create({ observer -> Disposable in
            let _ = self.sendRequest(path: Path.featuredPlaylists.rawValue, method: HTTPMethod.get).subscribe(onSuccess: { (item: ResponseListItem<[PlayList]>) in
                observer.onNext(item.data!)
                observer.onCompleted()
            }, onError: { (error) in
                observer.onError(error)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    func getPlaylist(id: String) -> Observable<Tracks> {
        return Observable<Tracks>.create({ observer -> Disposable in
            let _ = self.sendRequest(path: Path.featuredPlaylists.rawValue + "/\(id)", method: HTTPMethod.get).subscribe(onSuccess: { (item: Tracks) in
                observer.onNext(item)
                observer.onCompleted()
            }, onError: { (error) in
                observer.onError(error)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
}
