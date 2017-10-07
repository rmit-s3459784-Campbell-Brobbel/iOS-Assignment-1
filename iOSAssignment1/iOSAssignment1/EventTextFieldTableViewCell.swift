//
//  EventTextFieldTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/9/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField : UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


