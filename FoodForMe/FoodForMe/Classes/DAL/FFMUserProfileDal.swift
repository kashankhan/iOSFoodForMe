//
//  FFMUserProfileDal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import AlecrimCoreData

class FFMUserProfileDal: FFMBaseDal {
    
    func saveFacebookProfile(user: FBGraphUser, completion: (UserProfile?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            let userProfile = dataContext.userProfiles.createOrGetFirstEntity(whereAttribute: "recipeId", isEqualTo: user.objectID)
            userProfile.userId = user.objectID
            userProfile.name = user.name
            userProfile.lastName = user.last_name
            userProfile.firstName = user.first_name
            userProfile.birthday = (user.birthday != nil) ? user.birthday : ""
            var userEmail = user.objectForKey("email") as String
            userProfile.email = userEmail
            userProfile.profileLink = user.link
            // Save the background data context.
            let (success, error) = backgroundDataContext.save()
            if !success {
                // Replace this implementation with code to handle the error appropriately.
                println("Unresolved error \(error), \(error?.userInfo)")
            }
            
            completion(userProfile)
            
        }
    
    }
}