//
//  CoreDataStackManager.swift
//  VirtualTourist_Udacity
//
//  Created by Shanmathi Mayuram Krithivasan on 1/2/16.
//  Copyright © 2016 Shanmathi Mayuram Krithivasan. All rights reserved.
//

import Foundation
import CoreData

/**
 * The CoreDataStackManager contains the code that was Apple puts in the AppDelegate
 * in many of the Xcode templates.
 */

class CoreDataStackManager {
    
    // MARK: - Shared Instance
    class func sharedInstance() -> CoreDataStackManager {
        struct Static {
            static let instance = CoreDataStackManager()
        }
        
        return Static.instance
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Shanmathi.VirtualTourist_Udacity" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("VirtualTourist_Udacity", withExtension: "momd")!
        let mom = NSManagedObjectModel(contentsOfURL: modelURL)
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
        
        let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        
        var error: NSError? = nil
        
        var store: NSPersistentStore?
        do {
            store = try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        } catch var error1 as NSError {
            error = error1
            store = nil
        } catch {
            fatalError()
        }
        if (store == nil) {
            print("Failed to load store")
        }
        
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = psc
        
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        
        if let context = self.managedObjectContext {
            
            var error: NSError? = nil
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch let error1 as NSError {
                    error = error1
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    }
