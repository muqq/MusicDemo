//
//  Service.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/4.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation

protocol Service {
    var APIService: APIService { get set }
}

class KKDemoService: Service {
    
    var APIService: APIService
    
    init() {
        self.APIService = API()
    }
}
