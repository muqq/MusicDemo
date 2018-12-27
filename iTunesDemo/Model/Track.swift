//
//  Track.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/10.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Track: Object, Codable, ListItemProtocol {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var duration: Int = 0
    @objc dynamic var album: Album!
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Tracks: Object, Codable {
    @objc dynamic var tracks: TrackData!
    @objc dynamic var id: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

class TrackData: Object, Codable {
    var data = List<Track>()
}
