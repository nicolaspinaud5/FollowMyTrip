//
//  SavedListTableViewController.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 05/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import UIKit
import RealmSwift

/// Controller gérant l'affichage de la liste de Location
class SavedListTableViewController: UITableViewController {
    
    var savedLocations: Results<Location>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// On récupère toutes les Location de la base de donnée
        savedLocations = LocationManager.getAll()
        
        /// On défini un objet de type UILongPressGestureRecognizer qui permettra de déclencher la fonction longPressDelete lorsqu'un long clique sera effectué
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(SavedListTableViewController.longPressDelete))
        
        /// On défini le temps minimum du clique pour que le Recognizer déclenche la fonction
        longpress.minimumPressDuration = 0.7
        
        /// On dis à la tableView que longpress devra être déclenché si un long clique est éfféctué sur une de ces cellules
        tableView.addGestureRecognizer(longpress)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// On transmet à la tableView le nombre de cellule à affiché par section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// On retourne le nombre de Location sauvegardé en base de donnée, si il y en a
        if let location = savedLocations {
            return location.count
        }
        
        /// Sinon on retourne 0
        return 0
    }
    
    /// On spécifie à la tableView que l'on veut une seule section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// On récupère une cellule avec l'identifier "Cell" en tant que "SavedListTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SavedListTableViewCell
        
        /// On vérifie qu'il y a des Location dans la base de donnée et on unwrap le tableau savedLocations
        if let location = savedLocations {
            
            /// Si il y en a on spécifie le texte du positionNameLabel avec le nom de la Location récupérée dans le tableau location
        	cell.positionNameLabel.text = location[indexPath.row].name

            /// On assigne au locationId, l'id de l'objet Location récupérée dans le tableau location
            cell.locationId = location[indexPath.row].id
        }
        
        /// On retourne la célulle modifiée
        return cell
    }
    
    /// On spécifie à la tableView que l'on veut une en-tête de liste avec un texte spécifique
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved Locations"
    }
    
    /// On change ici la couleur de l'en-tête de liste
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.tintColor = UIColor(red:0.56, green:0.82, blue:0.99, alpha:1.00)
        }
    }
    
    /// On spécifie la taille de l'en-tête de liste
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    /// On dis à la tableView que ses cellules seront editables
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// On vérifie que la cellule présente à l'indexPath courant est editable
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        /// On vérifie que l'opération delete à été déclenché
        if editingStyle == .delete {
            
            /// Si c'est le cas on récupere la cellule à l'indexPath courant en tant que SavedListTableViewCell
            let cell = tableView.cellForRow(at: indexPath) as! SavedListTableViewCell
            
            /// On déclare une alert demandant à l'utilisateur de confirmer la suppression
            let alertController = UIAlertController(title: "Confirm that you want to delete this location", message: "", preferredStyle: .alert)
            
            /// On déclare une action permettant de fermer l'alert
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in }
            
            /// On déclare une action permettant de supprimer la Location selectionnée
            let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action:UIAlertAction!) in
                
                /// On supprime la Location ayant l'id locationId de la base de donnée
                LocationManager.delete(cell.locationId)
                
                /// On demande à la tableView de recharger ses données
                self.tableView.reloadData()
                
                /// Si il n'y a plus de Location en base on dépile ce ViewController du navigationContoller pour revenir à la vue ViewController
                if LocationManager.getAll().isEmpty {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
            
            /// On ajoute les actions au Controller
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            /// On affiche l'alert
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func longPressDelete(gestureRecognizer: UIGestureRecognizer) {
        
        /// On récupère le geste qui à déclenché cette fonction en tant que UILongPressGestureRecognizer
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        
        /// On récupère son état
        let state = longPress.state
        
        /// On récupère le point qui à été cliqué dans la tableView
        let locationInTableView = longPress.location(in: tableView)
        
        /// On récupère l'index de l'élément qui à été cliqué
        let indexPath = tableView.indexPathForRow(at: locationInTableView)
        
        switch state {
        
        /// Si le geste "long clique" à été recu par le recognizer longPress
        case UIGestureRecognizerState.began:
            
            /// On vérifie que l'index à été récupéré
            if indexPath != nil {
                
                /// Si c'est le cas on récupere la cellule à l'indexPath courant en tant que SavedListTableViewCell
                let cell = tableView.cellForRow(at: indexPath!) as! SavedListTableViewCell
                
                /// On déclare une alert demandant à l'utilisateur de confirmer la suppression
                let alertController = UIAlertController(title: "Confirm that you want to delete this location", message: "", preferredStyle: .alert)
                
                /// On déclare une action permettant de fermer l'alert
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in }
                
                /// On déclare une action permettant de supprimer la Location selectionnée
                let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action:UIAlertAction!) in
                    
                    /// On supprime la Location ayant l'id locationId de la base de donnée
                    LocationManager.delete(cell.locationId)
                    
                    /// On demande à la tableView de recharger ses données
                    self.tableView.reloadData()
                    
                    /// Si il n'y a plus de Location en base on dépile ce ViewController du navigationContoller pour revenir à la vue ViewController
                    if LocationManager.getAll().isEmpty {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                }
                
                /// On ajoute les actions au Controller
                alertController.addAction(cancelAction)
                alertController.addAction(deleteAction)
                
                /// On affiche l'alert
                self.present(alertController, animated: true, completion: nil)
            }
        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// On vérifie que le segue déclenché porte l'identifier "DetailsView"
        if segue.identifier == "DetailsView" {
            
            /// Si c'est le cas on vérifie qu'il y a un Controller de destination et on le récupère en tant que DetailsViewController
            if let destinationVC = segue.destination as? DetailsViewController {
                
                /// On récupère l'index de la cellule sélectionné si il n'est pas nil
                if let cellIndex = self.tableView.indexPathsForSelectedRows {
                    
                    /// On vérifie qu'il y a des Location dans la base de donnée et on unwrap le tableau savedLocations
                    if let location = savedLocations {
                        
                        /// On dis à la DetailsViewController que la Location courante est celle à l'index cellIndex[0][1] dans le tableu location
                        destinationVC.selectedLocation = location[cellIndex[0][1]]
                    }
                }
            }
        }
    }
}
