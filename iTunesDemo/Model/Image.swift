//
//  Image.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/6.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift

class Image: Object, Codable {
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var url: String = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
