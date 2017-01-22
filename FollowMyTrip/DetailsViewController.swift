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
    
    var location: Location = Location()
    
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var positionLatitudeLabel: UILabel!
    @IBOutlet weak var positionLongitudeLabel: UILabel!
    @IBOutlet weak var positionAltitudeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionNameLabel.text = location.name
        positionLatitudeLabel.text = "Latitude : \(location.latitude)"
        positionLongitudeLabel.text = "Longitude : \(location.longitude)"
        positionAltitudeLabel.text = "Altitude : \(location.altitude)"
        commentLabel.text = location.comment
        let goButton = UIBarButtonItem(title: "Go", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailsViewController.goToNewLocation(_:)))
        self.navigationItem.rightBarButtonItem = goButton
    }
    
    func goToNewLocation(_ sender:UIBarButtonItem!)
    {
        self.performSegue(withIdentifier: "backToMap", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMap" {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.goToNewLocation(location: location)
            }
    	}
    }
}
