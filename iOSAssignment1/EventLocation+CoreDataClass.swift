//
//  EventLocation+CoreDataClass.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 5/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import CoreData

@objc(EventLocation)
public class EventLocation: NSManagedObject {
    
    public func asString() -> String {
        return "\(self.name!), \(self.address!)"
    }
}
