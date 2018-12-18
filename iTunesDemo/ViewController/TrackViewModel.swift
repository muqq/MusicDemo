//
//  TrackViewModel.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/11.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class TrackViewModel: NSObject {
    
    private var track: Track
    private var isDirty = false
    var isFavortied = BehaviorSubject(value: false)
    var disposeBag = DisposeBag()
    let realmManager: RealmManagerProtocol
    
    init(track: Track, realmManager: RealmManagerProtocol) {
        self.track = track
        self.realmManager = realmManager
        super.init()
    }
    
    private func isTrackExistInRealm() -> Bool {
        let favoritedTrack: Results<Favorited> = self.realmManager.query().filter("id = %@", self.track.id)
        return favoritedTrack.elements.count != 0
    }
    
    func checkTrackIsFavorited() {
        if self.isTrackExistInRealm() {
            self.isFavortied.onNext(true)
        } else {
            self.isFavortied.onNext(false)
        }
    }
    
    func updateFavorite(isFavorite: Bool) {
        self.isFavortied.onNext(!isFavorite)
        self.isDirty = true
    }
    
    func saveStatus() {
        if self.isDirty == true {
            if try! self.isFavortied.value() == true {
                let favorited = Favorited()
                favorited.id = self.track.id
                favorited.iconURL = self.track.album.images.first?.url ?? ""
                favorited.title = self.track.name
                favorited.subTitle = self.track.album.artist.name
                self.realmManager.add(object: favorited)
            } else {
                let favoritedTrack: Results<Favorited> = self.realmManager.query().filter("id = %@", self.track.id)
                if favoritedTrack.count > 0 {
                    let _ = self.realmManager.delete(object: favoritedTrack.elements.first!)
                }
            }
        }
    }
}
