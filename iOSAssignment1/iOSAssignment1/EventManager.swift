//
//  EventManager.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import CoreData

/// Used to manage events pulled from Core Data.
class EventManager {
    
    /// A singleton object used to access events across all view controllers.
    public static var shared : EventManager = EventManager()
    
    /// An array of events
    private(set) var events : [Event] = []
    
    /// An array of locations used in all of the events in the events array.
    private(set) var userLocations : [Location] = []
    init() {
    }
    
    /// Load all the events saved in Core Data.
    public func loadEventsFrom(context: NSManagedObjectContext) {

        do {
            let eventArray : [WeatherEvent] = try context.fetch(WeatherEvent.fetchRequest())

            for event in eventArray {
                let location = Location(name: event.eventLocation!.name!, address: event.eventLocation!.address!, city: event.eventLocation!.city!, country: event.eventLocation!.country!)
                let newEvent = Event(eventTitle: event.title!, eventDateTime: event.dateTime! as Date, location: location)
                WeatherManager.shared.addUserLocation(location: location, completion: {})
                self.events.append(newEvent)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
       
    }
    
    /// Returns an array of events that are in the same day as the input date.
    public func eventsFor(day : Date) -> [Event] {
        
        var eventsForDay : [Event] = []
        
        for event in events {
                        
            if Calendar.current.isDate(event.eventDateTime, inSameDayAs: day){
                eventsForDay.append(event)
             
            }
        }
        
        return eventsForDay
    }
    
    /// Updates the forecast details for all of the events
    public func updateAllEventForecasts() -> Void {
        for event in self.events {
            event.updateForecast()
        }
    }
    
    /// Adds a single event
    public func addEvent(event : Event) {
        self.events.append(event)
    }
    
}
