//
//  ResponseItem.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/4.
//  Copyright © 2018 n1. All rights reserved.
//

struct ResponseListItem<T: Codable>: Codable {
    let data: T?
    let paging: Paging
    let summary: Summary
}

struct Paging: Codable {
    let offset: Int
    let limit: Int
    let previous: String?
    let next: String?
}

struct Summary: Codable {
    let total: Int
}
