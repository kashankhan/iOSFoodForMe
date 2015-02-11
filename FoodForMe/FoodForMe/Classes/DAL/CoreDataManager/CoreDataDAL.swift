//
//  CoreDataManager.swift
//  TUM_iOS_FoodRecommenderSystem
//
//  Created by Kashan Khan on 09/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataDAL: NSObject {
    
    let store: CoreDataStore! = CoreDataStore()
    
    override init(){
        super.init()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contextDidSaveContext:", name: NSManagedObjectContextDidSaveNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveContext", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveContext", name: UIApplicationWillTerminateNotification, object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // #pragma mark - Core Data stack
    
    // Returns the managed object context for the application.
    // Normally, you can use it to do anything.
    // But for bulk data update, acording to Florian Kugler's blog about core data performance, [Concurrent Core Data Stacks – Performance Shootout](http://floriankugler.com/blog/2013/4/29/concurrent-core-data-stack-performance-shootout) and [Backstage with Nested Managed Object Contexts](http://floriankugler.com/blog/2013/5/11/backstage-with-nested-managed-object-contexts). We should better write data in background context. and read data from main queue context.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    // main thread context
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // Returns the background object context for the application.
    // You can use it to process bulk data update in background.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var backgroundContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = coordinator
        return backgroundContext
        }()
    
    
    // save NSManagedObjectContext
    func saveContext (context: NSManagedObjectContext) {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
    }
    
    func saveContext () {
        self.saveContext( self.backgroundContext! )
    }
    
    // call back function by saveContext, support multi-thread
    func contextDidSaveContext(notification: NSNotification) {
        let sender = notification.object as NSManagedObjectContext
        if sender === self.managedObjectContext {
            NSLog("******** Saved main Context in this thread")
            self.backgroundContext!.performBlock {
                self.backgroundContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
        } else if sender === self.backgroundContext {
            NSLog("******** Saved background Context in this thread")
            self.managedObjectContext!.performBlock {
                self.managedObjectContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
        } else {
            NSLog("******** Saved Context in other thread")
            self.backgroundContext!.performBlock {
                self.backgroundContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
            self.managedObjectContext!.performBlock {
                self.managedObjectContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
        }
    }
    
    func fecthRequest(entityName: String, predicate: NSPredicate, managedObjectContext:NSManagedObjectContext, ascending: Bool, key: String) -> [AnyObject]? {
    
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: entityName)
        fReq.predicate = predicate
        if !key.isEmpty {
            var sorter: NSSortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
            fReq.sortDescriptors = [sorter]
        }
        
       return managedObjectContext.executeFetchRequest(fReq, error:&error)
    }
    
    
    func fecthRequest(entityName: String, predicate: NSPredicate, managedObjectContext:NSManagedObjectContext) -> [AnyObject]? {
        
      return fecthRequest(entityName, predicate: predicate, managedObjectContext: managedObjectContext, ascending: true, key: "")
    }
    
    func createEntity(entityName: String, managedObjectContext:NSManagedObjectContext) -> AnyObject {
       
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext:managedObjectContext)
    }
    
    func deleteManagedObject(managedObject: NSManagedObject, managedObjectContext:NSManagedObjectContext) {
    
         managedObjectContext.deleteObject(managedObject)
    }
    
    func findManagedObject(entityName: String, predicate: NSPredicate, managedObjectContext:NSManagedObjectContext, createNewIfNotFount: Bool) -> AnyObject {
    
        var manageObject: AnyObject?
        let result =  fecthRequest(entityName, predicate: predicate, managedObjectContext: managedObjectContext)! as NSArray
        if result.count > 0 {
            manageObject = result[0]
        }
        else {
            manageObject = self.createEntity(entityName, managedObjectContext: self.backgroundContext!)
        }
        
        return manageObject!
    }
}