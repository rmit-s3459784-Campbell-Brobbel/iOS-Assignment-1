//
//  EventManager.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 26/8/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation

class EventManager {
    
    public static var shared : EventManager = EventManager()
    private(set) var events : [Event] = []
    
    init() {
       createEvents()
        for event in events {
            print(event.forecast?.toString() ?? "Forecast Is Nil")
        }
    }
    
    private func createEvents() {
        
        let tomorrow = Date(timeIntervalSinceNow: 87000)
        let dayAfter1 = Date(timeIntervalSinceNow: 174000)
        let dayAfter2 = Date(timeIntervalSinceNow: 220000)
        let dayAfter3 = Date(timeIntervalSinceNow: 340000)


        let e1 = [Event(eventTitle: "Basketball Game", eventDateTime: Date(), location: Location(city: "Melbourne", country: "AU")), Event(eventTitle: "Poker", eventDateTime: Date(), location: Location(city: "Melbourne", country: "AU")),Event(eventTitle: "Work", eventDateTime: Date(), location: Location(city: "Melbourne", country: "AU")),Event(eventTitle: "Relax Time", eventDateTime: tomorrow, location: Location(city: "Melbourne", country: "AU")),Event(eventTitle: "Dinner", eventDateTime: tomorrow, location: Location(city: "Melbourne", country: "AU")), Event(eventTitle: "Basketball Game", eventDateTime: dayAfter1, location: Location(city: "Melbourne", country: "AU")), Event(eventTitle: "Treasure Hunt", eventDateTime: dayAfter1, location: Location(city: "Melbourne", country: "AU")),Event(eventTitle: "Movie With Friends", eventDateTime: dayAfter2, location: Location(city: "Melbourne", country: "AU")),Event(eventTitle: "Dinner At Parents", eventDateTime: dayAfter2, location: Location(city: "Melbourne", country: "AU")),Event(eventTitle: "Ballet Lesson", eventDateTime: dayAfter3, location: Location(city: "Melbourne", country: "AU"))]
        self.events = e1
        
    }
    
    public func eventsFor(day : Date) -> [Event] {
        
        var eventsForDay : [Event] = []
        
        for event in events {
            
            if Calendar.current.isDate(event.eventDateTime, inSameDayAs: day){
                eventsForDay.append(event)
                
                print("\(Calendar.current.component(.day, from: event.eventDateTime))")
                print("\(Calendar.current.component(.day, from: day))")

            }
        }
        
        return eventsForDay
    }
    
    
    
    
}
