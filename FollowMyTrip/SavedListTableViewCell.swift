//
//  SavedListTableViewCell.swift
//  FollowMyTrip
//
//  Created by Nicolas Pinaud on 05/01/2017.
//  Copyright © 2017 van. All rights reserved.
//

import UIKit

class SavedListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionNameLabel: UILabel!
    
    var locationId: Int8 = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
