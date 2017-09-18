//
//  EventDetailsTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventDetailsTableViewCell: UITableViewCell {
    
    var event : Event?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func updateCellWithEvent(event : Event) {
        self.event = event
        let hour = Calendar.current.component(.hour, from: event.eventDateTime)
        let minute = Calendar.current.component(.minute, from: event.eventDateTime)
        self.timeLabel.text = "\(hour):\(minute)"
        self.eventTitleLabel.text = "\(event.eventTitle)"
        self.eventLocationLabel.text = "\(event.location.city!), \(event.location.country!)"
        self.forecastImage.image = self.event?.forecast?.forecastImage
    }
}
