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

let dataContext = DataContext()!

final class DataContext: AlecrimCoreData.Context {
    
    var userProfiles: AlecrimCoreData.Table<UserProfile> { return AlecrimCoreData.Table<UserProfile>(context: self) }
    
    var recipes: AlecrimCoreData.Table<Recipe> { return AlecrimCoreData.Table<Recipe>(context: self) }
    
    var ingredients: AlecrimCoreData.Table<Ingredient> { return AlecrimCoreData.Table<Ingredient>(context: self) }
    
    var nutritions: AlecrimCoreData.Table<NutritionInfo> { return AlecrimCoreData.Table<NutritionInfo>(context: self) }
    
    var recipeCategories: AlecrimCoreData.Table<RecipeCategory> { return AlecrimCoreData.Table<RecipeCategory>(context: self) }
    
    var recommendedRecipes: AlecrimCoreData.Table<RecommendedRecipe> { return AlecrimCoreData.Table<RecommendedRecipe>(context: self) }
    
}
