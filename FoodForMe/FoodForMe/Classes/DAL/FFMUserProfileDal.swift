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
    
    func saveFacebookProfile(user: FBGraphUser) -> UserProfile {
        let userProfile = self.dataContext.userProfiles.firstOrCreated(whereAttribute: "userId", isEqualTo: user.objectID)
        userProfile.userId = user.objectID
        userProfile.name = user.name
        userProfile.lastName = user.last_name
        userProfile.firstName = user.first_name
        userProfile.birthday = (user.birthday != nil) ? user.birthday : ""
        var userEmail = user.objectForKey("email") as! String
        userProfile.email = userEmail
        userProfile.profileLink = user.link
        userProfile.gender = user.objectForKey("gender") as! String
        
        // Save the data context.
        let (success, error) = dataContext.save()
        if !success {
            // Replace this implementation with code to handle the error appropriately.
            println("Unresolved error \(error), \(error?.userInfo)")
            
        }
        
        return userProfile
    }
    
    func getUserProfile() -> UserProfile? {
        var userProfile: UserProfile?
        if let profiles:[UserProfile] = dataContext.userProfiles.toArray() as [UserProfile]? {
            if profiles.count > 0 {
                userProfile = profiles[0]
            }
        }
       return userProfile
    }
    
    func deleteUserProfile() {
        dataContext.userProfiles.delete()
    }
}