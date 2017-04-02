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

/// Controller gérant l'affichage des détails d'une Location
class DetailsViewController: UIViewController {
    
    var selectedLocation: Location = Location()
    
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var positionLatitudeLabel: UILabel!
    @IBOutlet weak var positionLongitudeLabel: UILabel!
    @IBOutlet weak var positionAltitudeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// On assigne au propriétés affichéés dans cette vue les latitude, longitude et altitude, nom de location et commentaires de location transmis par le SavedListTableViewController via le segue
        positionNameLabel.text = selectedLocation.name
        positionLatitudeLabel.text = "Latitude : \(selectedLocation.latitude)"
        positionLongitudeLabel.text = "Longitude : \(selectedLocation.longitude)"
        positionAltitudeLabel.text = "Altitude : \(selectedLocation.altitude)"
        commentLabel.text = selectedLocation.comment
        
        /// On crée un élément un boutton de type UIBarButtonItem qui va déclencher la fonction goToNewLocation()
        let goButton = UIBarButtonItem(title: "Go", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailsViewController.goToSelectedLocation(_:)))
        
        /// On place ce button dans la navigationBar en tant qu'item positionné à droite
        self.navigationItem.rightBarButtonItem = goButton
    }
    
    /// Cette fonction déclenche le segue avec l'identifier BackToMapView
    func goToSelectedLocation(_ sender:UIBarButtonItem!)
    {
        self.performSegue(withIdentifier: "BackToMapView", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// On vérifie que le segue déclenché porte l'identifier "BackToMapView"
        if segue.identifier == "BackToMapView" {
            
            /// Si c'est le cas on vérifie qu'il y a un Controller de destination et on le récupère en tant que ViewController
            if let destinationVC = segue.destination as? ViewController {
                
                /// On appelle la fonction goToNewLocation du ViewController avec la Location courante
                destinationVC.goToNewLocation(location: selectedLocation)
            }
    	}
    }
}
