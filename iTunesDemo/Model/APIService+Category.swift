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
        return self.rxSendRequest(path: Path.newReleaseCategories.rawValue + "/\(id)")
    }
    
    func getCateogries() -> Observable<[Category]> {
        return self.rxSendRequest(path: Path.newReleaseCategories.rawValue).map { (item: ResponseListItem<[Category]>) -> [Category] in
            return item.data!
        }
    }
}
