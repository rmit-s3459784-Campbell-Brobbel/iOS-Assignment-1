//
//  EventBasicDetailsTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 27/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventBasicDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func updateCell(title: String, time: String, location: String) {
        self.titleLabel.text = title
        self.timeLabel.text = time
        self.locationLabel.text = location
    }

}
