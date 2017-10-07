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
        let loc = eventDetails.location
        let requestQuery = "\(loc.address!), \(loc.city!), \(loc.country!)"
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = requestQuery
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {response, error in
            let mapItem = response!.mapItems.first!
            let regionRadius: CLLocationDistance = 1000
            let location = mapItem.placemark.location
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate,
                                                                    regionRadius * 2.0, regionRadius*2.0)
            let annotation = MKPointAnnotation()
            annotation.coordinate = (location?.coordinate)!
            annotation.title = mapItem.name!
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        
        })
        
    }
    
    public func updateLocationWith(mapItem: MKMapItem) {
        
            let regionRadius: CLLocationDistance = 1000
            let location = mapItem.placemark.location
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate,
                                                                      regionRadius * 2.0, regionRadius*2.0)
            let annotation = MKPointAnnotation()
            annotation.coordinate = (location?.coordinate)!
            annotation.title = mapItem.name!
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(coordinateRegion, animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
            
        
    }

}
