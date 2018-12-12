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

struct Tracks: Codable {
    let tracks: TrackData!
}

struct TrackData: Codable {
    let data: [Track]
//    enum CodingKeys: String, CodingKey {
//        case data
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.data = try container.decode(List<Track>.self, forKey: .data)
//        super.init()
//    }
//
//
//    required init() {
//        super.init()
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        super.init(value: value, schema: schema)
//    }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        super.init(realm: realm, schema: schema)
//    }
//
    
}
