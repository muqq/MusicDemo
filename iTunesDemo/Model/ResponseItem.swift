//
//  ResponseItem.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/4.
//  Copyright © 2018 n1. All rights reserved.
//

struct ResponseItem<T: Codable>: Codable {
    let data: T?
}
