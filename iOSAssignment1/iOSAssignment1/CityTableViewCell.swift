//
//  CityTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 23/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    /// Label used for presenting city details.
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
