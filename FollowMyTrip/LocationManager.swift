//
//  LocationManager.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 08/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import Foundation
import RealmSwift

//Class static LocationManager permettant les intéractions avec la base de donnée

open class LocationManager {
    static var realm = try! Realm()
    
    class func create(name: String, latitude: Double, longitude: Double, altitude: Double, comment: String = ""){
        let maxId = realm.objects(Location.self).max(ofProperty: "id") as Int?
        
        var lastId: Int = 0
        
        if maxId != nil {
        	lastId = maxId!
        }
        
        try! realm.write {
            realm.create(Location.self, value: ["id": lastId+1, "name": name, "latitude": latitude, "longitude": longitude, "altitude": altitude, "comment": comment])
        }
    }
    
    class func update(id: Int8, name: String, latitude: Double, longitude: Double, altitude: Double, comment: String){
        try! realm.write {
            realm.create(Location.self, value: ["id": id, "name": name, "latitude": latitude, "longitude": longitude, "altitude": altitude, "comment": comment], update: true)
        }
    }
    
    class func delete(_ id: Int8){
        try! realm.write {
            realm.delete(realm.objects(Location.self).filter("id = \(id)"))
        }
    }
    
    class func getAll() -> Results<Location>{
        return realm.objects(Location.self)
    }
}
