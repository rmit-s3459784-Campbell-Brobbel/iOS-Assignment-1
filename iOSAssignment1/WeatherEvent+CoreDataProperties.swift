//
//  WeatherEvent+CoreDataProperties.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 5/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import CoreData


extension WeatherEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEvent> {
        let request = NSFetchRequest<WeatherEvent>(entityName: "WeatherEvent")
        request.returnsObjectsAsFaults = false
        return request
    }

    @NSManaged public var title: String?
    @NSManaged public var dateTime: NSDate?
    @NSManaged public var eventLocation: EventLocation?

}
