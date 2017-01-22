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

/// Controller gérant la sauvegarde des Location

class SavingViewController: UIViewController {
    
    @IBOutlet weak var postionName: UITextField!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var latitude: CLLocationDegrees = 0.00
    var longitude: CLLocationDegrees = 0.00
    var altitude: CLLocationDegrees = 0.00
    var newLocation: Location?

    @IBAction func saveAction(_ sender: Any) {
        
        /// On vérfie dans cette fonction qu'un nom a été spécifé et on unwrap le texte des UILabel contenant le nom et le commentaire pour cette position
        if let name = postionName.text, let comment = commentTextField.text, postionName.text != "" {
            
            /// Si ces vérifications ont réussi on regarde si on est dans le mode "édition" d'une Location (en vérifiant que la variable newLocation n'est pas nil)
            if let location = newLocation {
                
                /// Si on est en édition on met à jour la Location avec son nouveau nom et son nouveau commentaire
                LocationManager.update(id: location.id, name: name, latitude: location.latitude, longitude: location.longitude, altitude: location.altitude, comment: comment)
            } else {
                
                /// Sinon on crée une Location
                LocationManager.create(name: name, latitude: latitude, longitude: longitude, altitude: altitude, comment: comment)
            }
        }
        
        /// On dépile ensuite tous les ViewController du navigationController jusqu'a ce que l'on arrive au RootViewController étant le ViewController de notre application
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// On change l'apparence du button de sauvegarde afin d'avoir des bords arrondi
        saveButton.layer.cornerRadius = 10
        
        /// On regarde si on est dans le mode "édition" d'une Location (en vérifiant que la variable newLocation n'est pas nil)
        /// Si c'est le cas on assigne au propriétés affichéés dans cette vue les valeurs de cette Location
        /// Sinon on assigne au propriétés affichéés dans cette vue les latitude, longitude et altitude transmises par le ViewController via le segue
        if let location = newLocation {
            postionName.text = location.name
            latitude = location.latitude
            longitude = location.longitude
            altitude = location.altitude
            commentTextField.text = location.comment
        }
        
        latitudeLabel.text = "Latitude : \(latitude)"
        longitudeLabel.text = "Longitude : \(longitude)"
        altitudeLabel.text = "Altitude : \(altitude)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
