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

class Album: Object, Codable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var artist: Artist!
    var images = List<Image>()

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case url = "url"
        case images = "images"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(Artist.self, forKey: .artist)
        url = try container.decode(String.self, forKey: .url)
        images = try container.decode(List<Image>.self, forKey: .images)
        super.init()
    }
    
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
