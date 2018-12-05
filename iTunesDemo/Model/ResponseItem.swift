//
//  ResponseItem.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/4.
//  Copyright © 2018 n1. All rights reserved.
//

struct ResponseItem<T: Codable>: Codable {
    let data: T?
    let paging: Paging
    let summary: Summary
}

struct Paging: Codable {
    let offset: Int
    let limit: Int
    let previous: Int?
    let next: Int?
}

struct Summary: Codable {
    let total: Int
}
