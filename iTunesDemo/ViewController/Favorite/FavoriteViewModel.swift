//
//  FavoriteViewModel.swift
//  iTunesDemo
//
//  Created by Zoe.Lin on 2018/12/12.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


protocol FavoriteViewModelProtocol: AnyObject {
    var reloadFavoritedList: (() -> ())? { get set }
}

class FavoriteViewModel: NSObject, FavoriteViewModelProtocol {
    
    var reloadFavoritedList: (() -> ())?
    
    let realmManager: RealmManagerProtocol
    
    var favoritedList: Results<Favorited>!
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
        self.favoritedList = self.realmManager.query()
        super.init()
    }
    
    func checkFavoritedList() {
        let list: Results<Favorited> = self.realmManager.query()
        
        guard list != self.favoritedList else { return }
        
        self.favoritedList = list
        if let block = self.reloadFavoritedList {
            block()
        }
    }
    
    func checkFavoritedInfoExist(index: Int) -> Bool {
        return  index < self.favoritedList.count
    }
    
}
