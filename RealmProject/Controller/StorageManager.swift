//
//  StorageManager.swift
//  RealmProject
//
//  Created by Василий  on 16.02.2022.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func savePeople(_ person: [PersonModel]) {
        try! realm.write{
            realm.add(person)
        }
    }
}
