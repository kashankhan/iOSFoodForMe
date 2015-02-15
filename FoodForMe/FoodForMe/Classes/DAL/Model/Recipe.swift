//
//  Recipe.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var preparation: String
    @NSManaged var starRating: NSNumber
    @NSManaged var videoUri: String
    @NSManaged var recipeId: String
    @NSManaged var totalTries: NSNumber
    @NSManaged var category: String
    @NSManaged var cuisine: String
    @NSManaged var bookmark: NSNumber
    @NSManaged var reviewCount: NSNumber
    @NSManaged var imageUri: String
    @NSManaged var largeImageUri: String
    @NSManaged var subcategory: String
    @NSManaged var ingredients: Ingredient

}
