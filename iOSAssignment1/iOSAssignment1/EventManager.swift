//
//  EventManager.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import CoreData
class EventManager {
    
    public static var shared : EventManager = EventManager()
    private(set) var events : [Event] = []
    private(set) var userLocations : [Location] = []
    init() {
    }
    
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
    
    public func createEvents() {
        
//        let tomorrow = Date(timeIntervalSinceNow: 87000)
//        let dayAfter1 = Date(timeIntervalSinceNow: 174000)
//        let dayAfter2 = Date(timeIntervalSinceNow: 220000)
//        let dayAfter3 = Date(timeIntervalSinceNow: 340000)
//        
//        let e1 = Event(eventTitle: "Basketball Game", eventDateTime: Date(), location: Location(name: "Knox Basketball Stadium", city: "Boronia", country: "AU"))
//        let e2 = Event(eventTitle: "Poker", eventDateTime: Date(), location: Location(name: "Manhattan Hotel", city: "Ringwood", country: "AU"))
//        let e3 = Event(eventTitle: "Work", eventDateTime: Date(), location: Location(name: "Crown Casino", city: "Southbank", country: "AU"))
//        let e4 = Event(eventTitle: "Relax Time", eventDateTime: tomorrow, location: Location(name: "42 Jarma Road", city: "Heathmont", country: "AU"))
//        let e5 = Event(eventTitle: "Dinner", eventDateTime: tomorrow, location: Location(name: "42 Jarma Road", city: "Heathmont", country: "AU"))
//        let e6 =  Event(eventTitle: "Basketball Game", eventDateTime: dayAfter1, location: Location(name: "Knox   Basketball Stadium", city: "Boronia", country: "AU"))
//        let e7 = Event(eventTitle: "Treasure Hunt", eventDateTime: dayAfter1, location: Location(name: "Melbourne Central", city: "Melbourne", country: "AU"))
//        let e8 = Event(eventTitle: "Movie With Friends", eventDateTime: dayAfter3, location: Location(name: "Hoyts Eastland", city: "Ringwood", country: "AU"))
//        
//        let events = [e1,e2,e3,e4,e5,e6,e7,e8]
//        self.events = events
//        for event in self.events {
//            WeatherManager.shared.addUserLocation(location: event.location) {
//                
//            }
//        }
        
    }
    
    public func eventsFor(day : Date) -> [Event] {
        
        var eventsForDay : [Event] = []
        
        for event in events {
                        
            if Calendar.current.isDate(event.eventDateTime, inSameDayAs: day){
                eventsForDay.append(event)
             
            }
        }
        
        return eventsForDay
    }
    
    public func updateAllEventForecasts() -> Void {
        for event in self.events {
            event.updateForecast()
        }
    }
    
    public func addEvent(event : Event) {
        self.events.append(event)
    }
    
    public func save(event: Event){
        
    }
}
