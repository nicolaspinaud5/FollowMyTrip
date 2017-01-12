//
//  SavingViewController.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 05/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SavingViewController: UIViewController {
    
    @IBOutlet weak var postionName: UITextField!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveAction(_ sender: Any) {
        if let name = postionName.text, let comment = commentTextField.text, postionName.text != "" {
            if let new = location {
                LocationManager.update(id: new.id, name: new.name, latitude: new.latitude, longitude: new.longitude, altitude: new.altitude)
            } else {
                LocationManager.create(name: name, latitude: latitude, longitude: longitude, altitude: altitude, comment: comment)
            }
        }
    }
    var latitude: CLLocationDegrees = 0.00
    var longitude: CLLocationDegrees = 0.00
    var altitude: CLLocationDegrees = 0.00
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let new = location {
            latitude = new.latitude
            longitude = new.longitude
            altitude = new.altitude
        }
        saveButton.layer.cornerRadius = 10
        latitudeLabel.text = "Latitude : \(latitude)"
        longitudeLabel.text = "Longitude : \(longitude)"
        altitudeLabel.text = "Altitude : \(altitude)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

