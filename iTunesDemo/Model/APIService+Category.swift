//
//  APIService+Category.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/5.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RxSwift

extension API {
    
    func getCateogry(id: String) -> Observable<CategoryDetail> {
        return Observable<CategoryDetail>.create({ observer -> Disposable in
            let _ = self.sendRequest(path: Path.newReleaseCategories.rawValue + "/\(id)", method: HTTPMethod.get).subscribe(onSuccess: { (item: CategoryDetail) in
                observer.onNext(item)
                observer.onCompleted()
            }, onError: { (error) in
                observer.onError(error)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    func getCateogries() -> Observable<[Category]> {
        return Observable<[Category]>.create({ observer -> Disposable in
            let _ = self.sendRequest(path: Path.newReleaseCategories.rawValue, method: HTTPMethod.get).subscribe(onSuccess: { (item: ResponseListItem<[Category]>) in
                observer.onNext(item.data!)
                observer.onCompleted()
            }, onError: { (error) in
                observer.onError(error)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
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
}
