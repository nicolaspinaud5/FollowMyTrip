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
    
    var latitudeText: String = ""
    var longitudeText: String = ""
    var altitudeText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        latitudeLabel.text = latitudeText
        longitudeLabel.text = longitudeText
        altitudeLabel.text = altitudeText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

