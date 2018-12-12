//
//  CategoryDetail.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/7.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CategoryDetail: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var playlists: PlayLists!
    var images = List<Image>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case playlists
        case images = "images"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        playlists = try container.decode(PlayLists.self, forKey: .playlists)
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
