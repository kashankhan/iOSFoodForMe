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
        let userProfile = dataContext.userProfiles.createOrGetFirstEntity(whereAttribute: "userId", isEqualTo: user.objectID)
        userProfile.userId = user.objectID
        userProfile.name = user.name
        userProfile.lastName = user.last_name
        userProfile.firstName = user.first_name
        userProfile.birthday = (user.birthday != nil) ? user.birthday : ""
        var userEmail = user.objectForKey("email") as String
        userProfile.email = userEmail
        userProfile.profileLink = user.link

        return userProfile
    }
}