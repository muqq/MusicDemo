//
//  CategoryDetail.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/7.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryDetail: Object, Codable {
    @objc dynamic var id: String
    @objc dynamic var title: String
    @objc dynamic var playlists: PlayLists!
    let images = List<Image>()

}
