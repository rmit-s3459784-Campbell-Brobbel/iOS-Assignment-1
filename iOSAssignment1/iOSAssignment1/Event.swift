//
//  Event.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

class Event {
    
    public private(set) var eventTitle : String
    public private(set) var eventDateTime : Date
    public private(set) var location : Location
    public var forecast : WeatherForecast?
    
    
    init() {
        self.eventTitle = ""
        self.eventDateTime = Date()
        self.location = Location()
        updateForecast()
    }
    
    init(eventTitle: String, eventDateTime: Date, location: Location) {
        self.eventTitle = eventTitle
        self.eventDateTime = eventDateTime
        self.location = location
        updateForecast()
    }
    
    public func updateForecast() {
        self.forecast = WeatherManager.shared.forecastFor(location: self.location, closestTo: self.eventDateTime)
        print("Event Forecast Is Now \(forecast?.toString() ?? "nil")")
    }
    
    

}
