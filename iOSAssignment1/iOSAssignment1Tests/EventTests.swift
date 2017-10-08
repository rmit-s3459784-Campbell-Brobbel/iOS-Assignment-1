//
//  EventTests.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 8/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import XCTest

class EventTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let e1 = Event(eventTitle: "Event 1", eventDateTime: Date(), location: Location(name: "", address: "", city: "Melbourne", country: "AU"))
        let e2 = Event(eventTitle: "Event 2", eventDateTime: Date(), location: Location(name: "", address: "", city: "Melbourne", country: "AU"))
        let e3 = Event(eventTitle: "Event 3", eventDateTime: Date(), location: Location(name: "", address: "", city: "Melbourne", country: "AU"))
        let e4 = Event(eventTitle: "Event 4", eventDateTime: Date(), location: Location(name: "", address: "", city: "Melbourne", country: "AU"))
        let e5 = Event(eventTitle: "Event 5", eventDateTime: Date(), location: Location(name: "", address: "", city: "Melbourne", country: "AU"))
        
        EventManager.shared.addEvent(event: e1)
        EventManager.shared.addEvent(event: e2)
        EventManager.shared.addEvent(event: e3)
        EventManager.shared.addEvent(event: e4)
        EventManager.shared.addEvent(event: e5)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetEventsForDate() {
        print("Testing Get Events For Date")
        
        let events = EventManager.shared.eventsFor(day: Date())
        
        for event in events {
            XCTAssert(Calendar.current.isDate(Date(), inSameDayAs: event.eventDateTime), "Event is not in the correct date.")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
