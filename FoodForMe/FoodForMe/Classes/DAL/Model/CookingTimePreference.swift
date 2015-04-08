//
//  CookingTimePreference.swift
//  FoodForMe
//
//  Created by Kashan Khan on 08/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class CookingTimePreference: NSManagedObject {

    @NSManaged var time: NSNumber
    @NSManaged var selected: NSNumber
    @NSManaged var userProfile: UserProfile

}
