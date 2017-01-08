////
////  SavedListTableViewController.swift
////  FollowMyTrip
////
////  Created by Nicolas Pinaud on 05/01/2017.
////  Copyright © 2017 van. All rights reserved.
//

import UIKit
import RealmSwift

class SavedListTableViewController: UITableViewController {
    
    var savedLocations: Results<Location>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedLocations = LocationManager.getAll()
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(SavedListTableViewController.longPressDelete))
        longpress.minimumPressDuration = 1.0
        tableView.addGestureRecognizer(longpress)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let location = savedLocations {
            return location.count
        }
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SavedListTableViewCell
        if let location = savedLocations {
        	cell.positionNameLabel.text = location[indexPath.row].name
            cell.locationId = location[indexPath.row].id
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved Locations"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.tintColor = UIColor(red:0.56, green:0.82, blue:0.99, alpha:1.00)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func longPressDelete(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: locationInView)
        
        switch state {
        case UIGestureRecognizerState.began:
            if indexPath != nil {
                let cell = tableView.cellForRow(at: indexPath!) as! SavedListTableViewCell
                let alertController = UIAlertController(title: "Confirm that you want to delete this location", message: "", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                }
                alertController.addAction(cancelAction)
                
                let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action:UIAlertAction!) in
                    LocationManager.delete(cell.locationId)
                    self.tableView.reloadData()
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(deleteAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        default:
            break
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsView" {
            if let destinationVC = segue.destination as? DetailsViewController {
                if let cellIndex = self.tableView.indexPathsForSelectedRows {
                    if let location = savedLocations {
                        destinationVC.nameText = location[cellIndex[0][1]].name
                        destinationVC.latitude = location[cellIndex[0][1]].latitude
                        destinationVC.longitude = location[cellIndex[0][1]].longitude
                        destinationVC.altitude = location[cellIndex[0][1]].altitude
                        destinationVC.commentText = location[cellIndex[0][1]].comment
                    }
                }
            }
        }
    }
}
