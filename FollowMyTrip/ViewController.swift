//
//  ViewController.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 04/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

/// Controller contenant la MKMapView et gérant l'affichage ainsi que la mise à jour de la carte
/// Ce Controller implémente le protocol CLLocationManagerDelegate permettant de récupérer la position actuel ainsi que la mise à jour de cette position

 class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager?
    
    var currentLocation:CLLocation = CLLocation()
    
    var currentPositionPin:PositionPin?
    
    var selectedLocation:Location?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Follow My Trip"
        
        /// On instancie un CLLocationManager, on definie sont delegate en tant que self nous permettant de récupérer les évènements du CLLocationManager
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        /// On précise qu'il faut que la location soit la plus précise que possible
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        /// On demande à l'utilisateur l'autorisation pour toujours (toutes utilisations après cette validation) d'utiliser le services de localisation de l'appareil
        locationManager?.requestAlwaysAuthorization()
        
        /// On dis ensuite au locationManager de récuperer la location de l'appareil et de la mettre à jour si elle change
        locationManager?.startUpdatingLocation()
        
        /// On précise à la mapView que l'on veut qu'elle nous montre la location actuel de l'appareil et que l'on veut suivre cette appareil
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        /// Si la DetailsViewController à transmis une Location par le segue
        if let newLocation = selectedLocation {
            
            /// On definis une region de 2000 mètres autour du centre de la Location via (latitude, longitude) 
            let regionMeters = CLLocationDistance(2000)
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(
                CLLocationCoordinate2DMake(newLocation.latitude, newLocation.longitude), regionMeters, regionMeters), animated: true)
            
            /// On crée un PositionPin (de type Annotation) à ce point
            currentPositionPin = PositionPin(title: newLocation.name, subtitle: "\(newLocation.latitude) : \(newLocation.longitude)", coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
            
        } else {
            
            /// Sinon on récupère la location depuis le locationManager
            if locationManager?.location != nil {
            	currentLocation = (locationManager?.location)!
            }
            
            /// On crée un PositionPin (de type Annotation) à ce point
            currentPositionPin = PositionPin(title: "Your Location", subtitle: "", coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
        }
        
        /// On ajoute une Annotation à la MapView
        mapView.addAnnotation(currentPositionPin!)
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        /// Si un PositionPin est sur la carte, on le supprime de la mapView
        if let pin = currentPositionPin {
            mapView.removeAnnotation(pin)
        }
        
        /// Si la DetailsViewController à transmis une Location par le segue
        if let newLocation = selectedLocation {
            
            ///On crée une CLLocation avec les coordonnées de cette Location et on l'assigne à la currentLocation
            currentLocation = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
            
        } else {
            
            /// Sinon on récupère la location depuis le LocationManager et on l'assigne à la currentLocation
            currentLocation = (locationManager?.location)!
        }
        
        /// On modifie les coordonnées du currentPositionPin et on l'ajoute à la mapView
        currentPositionPin?.coordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        mapView.addAnnotation(currentPositionPin!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        NSLog("locationManager didFailWithError", error)
    }
    
    /// On assigne la Location passé en paramètre à une propriété selectedLocation utilisable dans tous le Controller
    func goToNewLocation(location: Location){
        selectedLocation = location
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// Si le segue qui a été déclenché porte l'identifier "SavingView"
        if segue.identifier == "SavingView" {
            let destinationVC = segue.destination as! SavingViewController
            
            /// On vérifie qu'il y a une valeur dans la propriété selectedLocation
            if let newLocation = selectedLocation {
                
                /// Si il y en a une, on assigne à la propriété newLocation du Controller de destination (SavingViewController) la valeur unwrap de selectedLocation
                destinationVC.newLocation = newLocation
            } else {
                
                /// Sinon on assigne respectivement au propriétés latitude,longitude et altitude du Controller de destination (SavingViewController) les coordonées de la propriété currentLocation
                destinationVC.latitude = self.currentLocation.coordinate.latitude
                destinationVC.longitude = self.currentLocation.coordinate.longitude
                destinationVC.altitude = self.currentLocation.altitude
            }
            
        /// Si le segue qui a été déclenché porte l'identifier "LocationListView"
        } else if segue.identifier == "LocationListView" {
            
            /// On regarde si il y a des Location en base de donnée, si il n'y en a pas on affiche une alert disant que l'on n'a pas trouvé de Location en base
            if LocationManager.getAll().isEmpty {
                let alertController = UIAlertController(title: "No location found in Database", message: "", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in }
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
