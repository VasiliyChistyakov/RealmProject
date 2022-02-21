//
//  PersonModel.swift
//  RealmProject
//
//  Created by Василий  on 16.02.2022.
//

import Foundation
import RealmSwift

class PersonModel: Object {
    @Persisted var name = ""
    @Persisted var surname = ""
    @Persisted var birthdayDate = Date()
    
    
}
