//
//  RecommendedRecipe.swift
//  FoodForMe
//
//  Created by Kashan Khan on 05/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class RecommendedRecipe: NSManagedObject {

    @NSManaged var favoriteIngredientsInRepcie: String
    @NSManaged var identifier: NSNumber
    @NSManaged var preferCookingTime: NSNumber
    @NSManaged var recipe: Recipe

}
