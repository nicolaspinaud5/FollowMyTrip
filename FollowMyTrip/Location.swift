//
//  Location.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 08/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    dynamic var id: Int8 = 0
    dynamic var name: String = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var altitude: Double = 0.0
    dynamic var comment: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
