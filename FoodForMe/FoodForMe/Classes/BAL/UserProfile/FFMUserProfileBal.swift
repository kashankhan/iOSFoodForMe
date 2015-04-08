//
//  FFMUserProfileBal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 08/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class FFMUserProfileBal: FFMBaseBal {
    
    func saveUserProfile(profile: UserProfile,  complettion: (NSDictionary?) -> Void) {
        let parameters = ["userId": profile.userId,
            "birthday": profile.birthday,
            "email": profile.email,
            "firstName":profile.firstName,
            "lastName":profile.lastName,
            "name": profile.name,
            "gender": profile.gender,
            "profileLink": profile.profileLink]
        Alamofire.request(.POST, FFMUserProfileBalURLRequest.Router.saveUserProfile().URLRequest.URLString, parameters: parameters, encoding:  .JSON).response {(request, response, _, error) in
            println(response)
            println(error)
        }
    }
    
}