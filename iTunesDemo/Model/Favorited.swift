//
//  File.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/12.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation

import RealmSwift

class Favorited: Object {
    @objc dynamic var id: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
