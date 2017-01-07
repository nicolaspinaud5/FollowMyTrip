////
////  SavedListTableViewController.swift
////  FollowMyTrip
////
////  Created by Nicolas Pinaud on 05/01/2017.
////  Copyright © 2017 van. All rights reserved.
//

import UIKit

class SavedListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentRow: String!
    
    var savedPositionNames = ["My car's position", "My tent's position", "A big moument in Paris","Another big monument in Paris"]
    
    var savedPositionLatitudes = ["19.8789","-109.71097","10.17091","-19.017907"]
    
    var savedPositionLongitudes = ["89.9779","-122.54456","17.1","-2.907"]
    
    var savedPositionAltitudes = ["89.88","33.2","12.333","1.2222"]
    
    var savedPositionComments = ["Wa's up right deh","Yuh get dat tune","Ruff up","Bend down","Bang bim"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.savedPositionNames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SavedListTableViewCell
        cell.positionNameLabel.text = savedPositionNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saved Locations"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.backgroundColor = UIColor(red:0.56, green:0.82, blue:0.99, alpha:1.00)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = "jkbkj"
        self.performSegue(withIdentifier: "DetailsView", sender: currentRow)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsView" {
//            var ind = sender as! Int
//            print(ind)
            if let destinationVC = segue.destination as? DetailsViewController {
                if let name = sender as? String {
                    destinationVC.altitudeText = name
                    print("hello")
                }
            }
//            destinationVC.nameText = savedPositionNames[currentRow]
//            destinationVC.latitudeText = savedPositionLatitudes[currentRow]
//            destinationVC.longitudeText = savedPositionLongitudes[currentRow]
//            destinationVC.altitudeText = savedPositionAltitudes[currentRow]
//            destinationVC.commentText = savedPositionComments[currentRow]
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
}
