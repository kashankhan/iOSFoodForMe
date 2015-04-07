//
//  IngredientPreference.swift
//  FoodForMe
//
//  Created by Kashan Khan on 07/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class IngredientPreference: NSManagedObject {

    @NSManaged var favorite: NSNumber
    @NSManaged var ingredient: String
    @NSManaged var userProfile: UserProfile

}
