//
//  Recipe.swift
//  FoodForMe
//
//  Created by Kashan Khan on 04/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {

    @NSManaged var activeMinutes: NSNumber
    @NSManaged var allCategoriesText: String
    @NSManaged var category: String
    @NSManaged var cuisine: String
    @NSManaged var favoriteCount: NSNumber
    @NSManaged var imageUri: String
    @NSManaged var instructions: String
    @NSManaged var largeImageUri: String
    @NSManaged var preparation: String
    @NSManaged var primaryIngredient: String
    @NSManaged var recipeDescription: String
    @NSManaged var recipeId: String
    @NSManaged var reviewCount: NSNumber
    @NSManaged var starRating: NSNumber
    @NSManaged var subcategory: String
    @NSManaged var title: String
    @NSManaged var totalMinutes: NSNumber
    @NSManaged var totalTries: NSNumber
    @NSManaged var yieldNumber: NSNumber
    @NSManaged var yieldUnit: String
    @NSManaged var ingredients: NSSet
    @NSManaged var nutritionInfo: NutritionInfo
    @NSManaged var recommendation: RecommendedRecipe

}
