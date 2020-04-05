//
//  StorageManager .swift
//  MyPlaces
//
//  Created by Anatolii Stoliarenko on 31/03/2020.
//  Copyright © 2020 Anatolii Stoliarenko. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            
            //сейчас realm и является нашей базой данных. Добавляем запись
            realm.add(place)
        }
    }
    
    //реализовывем метод для удаления записей из базы данных
    static func deletedObject(_ place: Place) {
        
        //сейчас realm и является нашей базой данных. Удаляем запись
        try! realm.write {
            realm.delete(place)
        }
    }
}
