//
//  EventLocationTableViewCell.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 20/9/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import UIKit
import MapKit

class EventLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mapView.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func updateLocationWith(eventDetails: Event) {
        let regionRadius: CLLocationDistance = 1000
        let location = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius*2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }

}
