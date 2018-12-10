//
//  Track.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/10.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift

class Track: Object, Codable {
    @objc dynamic var id: String
    @objc dynamic var name: String
    @objc dynamic var url: String
    @objc dynamic var duration: Int
    @objc dynamic var album: Album?
    let images: List<Image>?
}

class Tracks: Object, Codable {
    let data: List<Track>!
}