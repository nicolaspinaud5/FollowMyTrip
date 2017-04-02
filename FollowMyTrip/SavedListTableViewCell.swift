//
//  SavedListTableViewCell.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 05/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import UIKit

/// Cette classe permet de personaliser la cellule de base UITableViewCell
/// On lui à ajouté un locationId permettant de faire l'association entre une cellule et une Location enregistrée en base de donnée

class SavedListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionNameLabel: UILabel!
    
    var locationId: Int8 = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
