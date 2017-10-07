//
//  Event.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

/// Contains information regarding a user's specific event details.
class Event {
    
    /// Title of the event
    public private(set) var eventTitle : String
    /// Date/Time of the event
    public private(set) var eventDateTime : Date
    /// Location of the event
    public private(set) var location : Location
    /// Forecast for the event. This may not be available for download.
    public var forecast : WeatherForecast?
    
    
    init() {
        self.eventTitle = "Blank Event"
        self.eventDateTime = Date()
        self.location = Location(name: "No Name",  address: "No Address", city: "No Name", country: "AU")
        updateForecast()
    }
    
    init(eventTitle: String, eventDateTime: Date, location: Location) {
        self.eventTitle = eventTitle
        self.eventDateTime = eventDateTime
        self.location = location
        updateForecast()
    }
    
    /// Updates the forecast for the event from the WeatherManager.
    public func updateForecast() {
        self.forecast = WeatherManager.shared.forecastFor(location: self.location, closestTo: self.eventDateTime)
    }
    
    

}
