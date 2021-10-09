//
//  RealmManager.swift
//  cartApp
//
//  Created by Payal Kandlur on 07/10/21.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {
    
    static let sharedManager = RealmManager()
    
    var realmDB = try! Realm()
    
    ///This function adds the data to the Realm database.
    func addObjects(_ model: Product) {
        try! self.realmDB.write {
            self.realmDB.add(model)
        }
        
    }
    
    ///This function deletes the data to the Realm database.
    func deleteObjects() {
        try! self.realmDB.write {
            self.realmDB.deleteAll()
        }
    }
    
}
