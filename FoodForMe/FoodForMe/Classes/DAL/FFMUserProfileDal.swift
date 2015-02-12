//
//  FFMUserProfileDal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class FFMUserProfileDal: CoreDataDal {
    
    func saveFacebookProfile(user: FBGraphUser) -> UserProfile? {
        let context: NSManagedObjectContext = self.backgroundContext!
        let entityName = "UserProfile"
        let predicate = NSPredicate(format:"userId = %@", user.objectID)
        var userProfile = fetchObject(entityName, context: context, predicate: predicate!) as? UserProfile
        if userProfile == nil {
            userProfile = createManagedObject(entityName, context: context) as? UserProfile
        }
        userProfile?.userId = user.objectID
        userProfile?.name = user.name
        userProfile?.lastName = user.last_name
        userProfile?.firstName = user.first_name
        userProfile?.birthday = (user.birthday != nil) ? user.birthday : ""
        var userEmail = user.objectForKey("email") as String
        userProfile?.email = userEmail
        userProfile?.profileLink = user.link
        
        self.saveContext(context)
        
        return userProfile
    
    }
}