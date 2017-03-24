//
//  Meal+CoreDataClass.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 3/21/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import Foundation
import CoreData

@objc(Meal)
public class Meal: NSManagedObject {

    class func fetchMeals (inManagedObjectContext context: NSManagedObjectContext) -> [Meal]?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
        
        do {
            let queryResult = try context.fetch(request) as! [Meal]
            print("Count of data in database \(queryResult.count)")
            return queryResult
        } catch let Error {
            print("Core Data Error \(Error)")
        }
        
        return nil
    }
}
