//
//  WeatherEvent+CoreDataClass.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 5/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import CoreData

@objc(WeatherEvent)
public class WeatherEvent: NSManagedObject {
    
    public func asString() -> String {
        return "\(self.title!), \(self.eventLocation!.asString()), \(self.dateTime!)"
    }

}
