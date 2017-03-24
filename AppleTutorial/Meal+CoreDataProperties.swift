//
//  Meal+CoreDataProperties.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 3/21/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal");
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var rating: Int16

}
