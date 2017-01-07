//
//  PositionPin.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 04/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import MapKit

class PositionPin: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
