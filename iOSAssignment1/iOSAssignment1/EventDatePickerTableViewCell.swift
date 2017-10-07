//
//  EventDatePickerTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/9/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventDatePickerTableViewCell: UITableViewCell {

    /// Date picker for selecting event date.
    @IBOutlet weak var datePicker : UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
