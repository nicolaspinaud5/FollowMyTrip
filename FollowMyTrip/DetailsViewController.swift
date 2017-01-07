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
    var latitudeText: String = ""
    var longitudeText: String = ""
    var altitudeText: String = ""
    var commentText:String = ""
    
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var positionLatitudeLabel: UILabel!
    @IBOutlet weak var positionLongitudeLabel: UILabel!
    @IBOutlet weak var positionAltitudeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionNameLabel.text = nameText
        positionLatitudeLabel.text = latitudeText
        positionLongitudeLabel.text = longitudeText
        positionAltitudeLabel.text = altitudeText
        commentLabel.text = commentText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

