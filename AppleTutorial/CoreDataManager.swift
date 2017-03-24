//
//  CoreDataManager.swift
//  Vacation
//
//  Created by Min thu Kyaw on 3/20/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import CoreData

final class CoreDataManager {
    
    // MARK: Properties
    
    private let modelName : String
    
    // MARK: Inititalization
    
    init(modelName:String) {
        self.modelName = modelName
    }
    
    // MARK: Set up CoreData Stack
    
    private (set) lazy var managedObjectContext : NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel : NSManagedObjectModel = {
        guard let modelUrl = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Could not get model url")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Unable to load managed object model")
        }
        
        return managedObjectModel
        
    }()
    
    private lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let persistentStoreUrl = documentsDirectoryUrl?.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreUrl,
                                                              options: nil)
            
        } catch  {
            fatalError("Unable to set up persistent store")
        }
        
        return persistentStoreCoordinator
    }()
    
    
}
