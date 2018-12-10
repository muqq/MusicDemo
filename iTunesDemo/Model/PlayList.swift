//
//  PlayList.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/7.
//  Copyright © 2018 n1. All rights reserved.
//

import RealmSwift
import Realm


class PlayList: Object, Codable, ListItemProtocol {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var url: String = ""
    var images: List<Image>?
    
    var paging: Paging!
    var summary: Summary!
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case desc = "description"
        case url = "url"
        case images = "images"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        desc = try container.decode(String.self, forKey: .desc)
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

class PlayLists: Object, Codable {
    let data: List<PlayList>!
}
