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
    func getCateogries() -> Observable<[Category]> {
        return Observable<[Category]>.create({ observer -> Disposable in
            let _ = self.sendRequest(path: Path.newReleaseCategories, method: HTTPMethod.get).subscribe(onSuccess: { (item: ResponseListItem<[Category]>) in
                observer.onNext(item.data!)
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create()
        })
    }
}
