//
//  RealmManager.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/11.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol RealmManagerProtocol {
    func add(object: Object)
    func delete(object: Object)
    func queryCollection<T: Object>(type: T.Type) -> Observable<Results<T>>
    func queryChangeSet<T: Object>(type: T.Type) -> Observable<(AnyRealmCollection<T>, RealmChangeset?)>
    func queryArray<T: Object>(type: T.Type) -> Observable<Array<T>>
    func query<T: Object>() -> Results<T>
    func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
}

typealias ObservableChangeSet<T: Object> = Observable<(AnyRealmCollection<T>, RealmChangeset?)>

class RealmManager: RealmManagerProtocol {
    
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func add(object: Object) {
        let _ = Observable.from(object: object).subscribe(self.realm.rx.add(update: true, onError: nil))
    }
    
    func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        let _ = Observable.from(optional: objects).subscribe(self.realm.rx.add(update: true, onError: nil))
    }
    
    func delete(object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let e {
            print(e)
        }
    }
    
    func delete<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch let e {
            print(e)
        }
    }
    
    func query<T: Object>() -> Results<T> {
        return realm.objects(T.self)
    }
    
    func queryCollection<T: Object>(type: T.Type) -> Observable<Results<T>> {
        return Observable.collection(from: realm.objects(T.self))
    }
    
    func queryChangeSet<T: Object>(type: T.Type) -> Observable<(AnyRealmCollection<T>, RealmChangeset?)> {
        return Observable.changeset(from: realm.objects(T.self))
    }
    
    func queryArray<T: Object>(type: T.Type) -> Observable<Array<T>> {
        return Observable.array(from: realm.objects(T.self))
    }
}
