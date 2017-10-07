//
//  EventLocation+CoreDataProperties.swift
//  iOSAssignment1
//
//  Created by Campbell Brobbel on 5/10/17.
//  Copyright © 2017 CampbellRhys. All rights reserved.
//

import Foundation
import CoreData


extension EventLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventLocation> {
        return NSFetchRequest<EventLocation>(entityName: "EventLocation")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?

}
