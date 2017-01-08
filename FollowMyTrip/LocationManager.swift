//
//  LocationManager.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 08/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import Foundation
import RealmSwift

open class LocationManager {
    static var realm = try! Realm()
    
    class func create(name: String, latitude: Double, longitude: Double, altitude: Double, comment: String = ""){
    	try! realm.write {
    		realm.create(Location.self, value: ["name": name, "latitude": latitude, "longitude": longitude, "altitude": altitude, "comment": comment])
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
