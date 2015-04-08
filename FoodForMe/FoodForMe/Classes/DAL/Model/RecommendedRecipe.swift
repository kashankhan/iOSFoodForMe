//
//  RecommendedRecipe.swift
//  FoodForMe
//
//  Created by Kashan Khan on 07/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class RecommendedRecipe: NSManagedObject {

    @NSManaged var explaination: String
    @NSManaged var favoriteIngredientsInRepcie: String
    @NSManaged var identifier: String
    @NSManaged var preferCookingTime: NSNumber
    @NSManaged var recipe: Recipe

}
