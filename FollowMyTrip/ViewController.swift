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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager?
    
    var currentLocation:CLLocation = CLLocation()
    
    var currentPositionPin:PositionPin?
    
    var newLocation:Location?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let pin = currentPositionPin {
            mapView.removeAnnotation(pin)
        }
        
        if let new = newLocation {
            currentLocation = CLLocation(latitude: new.latitude, longitude: new.longitude)
        } else {
            currentLocation = (locationManager?.location)!
        }
        currentPositionPin?.coordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        mapView.addAnnotation(currentPositionPin!)
	}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    }
    
    func goToNewLocation(location: Location){
        newLocation = location
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.requestLocation()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        if let new = newLocation {
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: new.latitude, longitude: new.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
            
            currentPositionPin = PositionPin(title: new.name, subtitle: "\(new.latitude) : \(new.longitude)", coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
        } else {
            currentLocation = (locationManager?.location)!
            
            currentPositionPin = PositionPin(title: "Position", subtitle: "Where you are", coordinate: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude))
        }
        mapView.addAnnotation(currentPositionPin!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavingView" {
            let destinationVC = segue.destination as! SavingViewController
            destinationVC.latitude = self.currentLocation.coordinate.latitude
            destinationVC.longitude = self.currentLocation.coordinate.longitude
            destinationVC.altitude = self.currentLocation.altitude
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
