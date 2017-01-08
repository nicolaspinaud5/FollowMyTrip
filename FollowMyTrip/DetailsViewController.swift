//
//  DetailsViewController.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 05/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    var nameText: String = ""
    var latitude: CLLocationDegrees = 0.00
    var longitude: CLLocationDegrees = 0.00
    var altitude: CLLocationDegrees = 0.00
    var commentText:String = ""
    
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var positionLatitudeLabel: UILabel!
    @IBOutlet weak var positionLongitudeLabel: UILabel!
    @IBOutlet weak var positionAltitudeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionNameLabel.text = nameText
        positionLatitudeLabel.text = "Latitude : \(latitude)"
        positionLongitudeLabel.text = "Longitude : \(longitude)"
        positionAltitudeLabel.text = "Altitude : \(altitude)"
        commentLabel.text = commentText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

