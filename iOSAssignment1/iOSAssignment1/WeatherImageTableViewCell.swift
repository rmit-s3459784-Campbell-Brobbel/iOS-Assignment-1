//
//  WeatherImageTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class WeatherImageTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
