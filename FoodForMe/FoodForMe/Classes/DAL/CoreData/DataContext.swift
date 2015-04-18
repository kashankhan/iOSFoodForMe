//
//  DataContext.swift
//  FoodForMe
//
//  Created by Kashan Khan on 18/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import UIKit
import Foundation
import AlecrimCoreData

final class DataContext: AlecrimCoreData.Context {
    
    var userProfiles: AlecrimCoreData.Table<UserProfile> { return AlecrimCoreData.Table<UserProfile>(context: self) }
    
    var recipes: AlecrimCoreData.Table<Recipe> { return AlecrimCoreData.Table<Recipe>(context: self) }
    
    var ingredients: AlecrimCoreData.Table<Ingredient> { return AlecrimCoreData.Table<Ingredient>(context: self) }
    
    var nutritions: AlecrimCoreData.Table<NutritionInfo> { return AlecrimCoreData.Table<NutritionInfo>(context: self) }
    
    var recommendedRecipes: AlecrimCoreData.Table<RecommendedRecipe> { return AlecrimCoreData.Table<RecommendedRecipe>(context: self) }
    
    var ingredientPreferences: AlecrimCoreData.Table<IngredientPreference> { return AlecrimCoreData.Table<IngredientPreference>(context: self) }
    
    var courses: AlecrimCoreData.Table<Course> { return AlecrimCoreData.Table<Course>(context: self) }
    
    var cookingTimings: AlecrimCoreData.Table<CookingTimePreference> { return AlecrimCoreData.Table<CookingTimePreference>(context: self) }
    
    
    internal func saveContext() {
        // Save the background data context.
        let (success, error) = self.save()
        if !success {
            // Replace this implementation with code to handle the error appropriately.
            println("Unresolved error \(error), \(error?.userInfo)")
            
        }
    
    }
    
}
