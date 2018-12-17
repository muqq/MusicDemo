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
        return self.rxSendRequest(path: Path.featuredPlaylists.rawValue)
    }
    
    func getPlaylist(id: String) -> Observable<[Track]> {
        return self.rxSendRequest(path: Path.featuredPlaylists.rawValue + "/\(id)").map { (item: Tracks) -> [Track] in
            return item.tracks.data
        }
    }
}
