//
//  RealmManager.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/12/11.
//  Copyright © 2018 n1. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func add(object: Object) -> Bool
    func delete(object: Object) -> Bool
    func query<T: Object>() -> Results<T>
    func add<S: Sequence>(_ objects: S) -> Bool where S.Iterator.Element: Object
    func delete<S: Sequence>(_ objects: S) -> Bool where S.Iterator.Element: Object
}

class RealmManager: RealmManagerProtocol {
    
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
        self.realm.autorefresh = true
    }
    
    func add(object: Object) -> Bool {
        do {
            try self.realm.write { [weak self] in
                self?.realm.add(object, update: true)
            }
            return true
        } catch {
            return false
        }
    }
    
    func add<S: Sequence>(_ objects: S) -> Bool where S.Iterator.Element: Object {
        do {
            try self.realm.write { [weak self] in
                self?.realm.add(objects, update: true)
            }
            return true
        } catch {
            return false
        }
    }
    
    func delete(object: Object) -> Bool {
        do {
            try self.realm.write { [weak self] in
                self?.realm.delete(object)
            }
            return true
        } catch {
            return false
        }
    }
    
    func delete<S: Sequence>(_ objects: S) -> Bool where S.Iterator.Element: Object {
        do {
            try self.realm.write { [weak self] in
                self?.realm.delete(objects)
            }
            return true
        } catch {
            return false
        }
    }
    
    func query<T: Object>() -> Results<T> {
        return realm.objects(T.self)
    }
}
