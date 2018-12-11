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

class TrackViewModel {
    
    let track: Track
    let realm: Realm
    var isFavortied = BehaviorSubject(value: false)
    
    
    init(track: Track) {
        self.track = track
        self.realm = AppDelegate.appDelegate().realm
    }
    
    func checkTrackIsFavorited() {
        let favortiedTrack = self.realm.objects(Track.self).filter("id != '%@'", self.track.id)
        self.isFavortied.onNext(favortiedTrack.count != 0)
    }
    
    func saveTrack() {
        try! realm.write {
            realm.add(self.track)
        }
    }
    
    func removeTrack() {
        try! realm.write {
            realm.delete(self.track)
        }
    }
}
