//
//  EventDetailsTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit

class EventDetailsTableViewCell: UITableViewCell {
    
    /// Event the cell uses as a data source.
    var event : Event?
    
    /// Event Time Label
    @IBOutlet weak var timeLabel: UILabel!
    /// Event Forecast Image
    @IBOutlet weak var forecastImage: UIImageView!
    /// Event Location Details Label
    @IBOutlet weak var eventLocationLabel: UILabel!
    /// Event Title Label
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Update the cell details with the details from an Event.
    public func updateCellWithEvent(event : Event) {
        self.event = event
        let hour = String(format: "%02d", Calendar.current.component(.hour, from: event.eventDateTime))
        let minute = String(format: "%02d", Calendar.current.component(.minute, from: event.eventDateTime))
        self.timeLabel.text = "\(hour):\(minute)"
        self.eventTitleLabel.text = "\(event.eventTitle)"
        self.eventLocationLabel.text = "\(event.location.city!), \(event.location.country!)"
        self.forecastImage.image = self.event?.forecast?.forecastImage
    }
}
