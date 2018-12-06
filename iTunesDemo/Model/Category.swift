//
//  Category.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/5.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object, Codable {
    @objc dynamic var id: String
    @objc dynamic var title: String
    let images: List<Image>!
}


