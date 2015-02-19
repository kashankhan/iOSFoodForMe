//
//  FFMRecipesParser.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import AlecrimCoreData

class FFMRecipesParser: FFMBaseParser {
    
    
    func parseRecipes(response: AnyObject, completion: (NSArray?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            var list: [Recipe] = []
            if response is NSDictionary {
                for recipeInfo in response["Results"] as NSArray {
                    let recipeId = NSString(format:"%d", recipeInfo["RecipeID"] as Int)
                    let recipe = dataContext.recipes.createOrGetFirstEntity(whereAttribute: "recipeId", isEqualTo: recipeId)
                    recipe.recipeId = recipeId
                    recipe.title = recipeInfo["Title"] as String
                    recipe.starRating = recipeInfo["StarRating"] as Int
                    recipe.totalTries = (recipeInfo["TotalTries"] is Int) ? recipeInfo["TotalTries"] as Bool : 0
                    recipe.category = recipeInfo["Category"] as String
                    recipe.subcategory = recipeInfo["Subcategory"] as String
                    recipe.cuisine = (recipeInfo["Cuisine"] is String) ? recipeInfo["Cuisine"] as String : ""
                    recipe.bookmark = (recipeInfo["IsBookmark"] is Bool) ? recipeInfo["IsBookmark"] as Bool : false
                    recipe.reviewCount = recipeInfo["ReviewCount"] as Int
                    recipe.imageUri = recipeInfo["ImageURL"] as String
                    recipe.largeImageUri = recipeInfo["HeroPhotoUrl"] as String
                    //recipe?.videoUri = recipeInfo["T"] as String
                    //recipe?.preparation = recipeInfo["T"] as String
                    list.append(recipe)
                    
                }
                
                // Save the background data context.
                let (success, error) = backgroundDataContext.save()
                if !success {
                    // Replace this implementation with code to handle the error appropriately.
                    println("Unresolved error \(error), \(error?.userInfo)")
                    
                }
                completion(list)
            }
        }
    }
    
    
     func parseRecipe(response: AnyObject, completion: (Recipe?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            let recipeId = NSString(format:"%d", response["RecipeID"] as Int)
            let recipe = dataContext.recipes.createOrGetFirstEntity(whereAttribute: "recipeId", isEqualTo: recipeId)
            recipe.recipeId = recipeId
            recipe.activeMinutes =  (response["ActiveMinutes"] is Int) ? response["ActiveMinutes"] as Int : 0
            recipe.recipeDescription = response["Description"] as String
            recipe.primaryIngredient = response["PrimaryIngredient"] as String
            recipe.totalMinutes = (response["TotalMinutes"] is Int) ? response["TotalMinutes"] as Int : 0
            recipe.yieldNumber = response["YieldNumber"] as Int
            recipe.yieldUnit = response["YieldUnit"] as String
            
            //NutritionInfo
            let nutritionInfo: NutritionInfo = self.parseNutritionInfo(response["NutritionInfo"], context: dataContext, recipe: recipe) as NutritionInfo!
            recipe.nutritionInfo = nutritionInfo
            //Ingredient
            for ingredientsInfo: AnyObject in response["Ingredients"] as Array {
                let ingredient = self.parseIngredient(ingredientsInfo, context: dataContext, recipe: recipe) as Ingredient!
                var ingredients = recipe.ingredients.mutableSetValueForKey("ingredients")
                ingredients.addObject(ingredient!)
            }
            
            // Save the background data context.
            let (success, error) = backgroundDataContext.save()
            if !success {
                // Replace this implementation with code to handle the error appropriately.
                println("Unresolved error \(error), \(error?.userInfo)")
            }
            
            completion(recipe)
            
        }
    }

    
    private func parseNutritionInfo(response: AnyObject?, context: DataContext, recipe: Recipe) -> NutritionInfo? {
        let entityName = "NutritionInfo"
        let nutritionInfo = dataContext.nutritions.createOrGetFirstEntity(whereAttribute: "recipeId", isEqualTo: recipe.recipeId)
        nutritionInfo.caloriesFromFat = response?["CaloriesFromFat"] as Int
        nutritionInfo.cholesterol = response?["Cholesterol"] as Int
        nutritionInfo.cholesterolPct = response?["CholesterolPct"] as Int
        nutritionInfo.dietaryFiber = response?["DietaryFiber"] as Int
        nutritionInfo.dietaryFiberPct = response?["DietaryFiberPct"] as Int
        nutritionInfo.monoFat = response?["MonoFat"] as Int
        nutritionInfo.polyFat = response?["PolyFat"] as Int
        nutritionInfo.potassium = response?["Potassium"] as Int
        nutritionInfo.potassiumPct = response?["PotassiumPct"] as Int
        nutritionInfo.protein = response?["Protein"] as Int
        nutritionInfo.proteinPct = response?["ProteinPct"] as Int
        nutritionInfo.satFat = response?["SatFat"] as Int
        nutritionInfo.satFatPct = response?["SatFatPct"] as Int
        nutritionInfo.singularYieldUnit = response?["SingularYieldUnit"] as String
        nutritionInfo.sodium = response?["Sodium"] as Int
        nutritionInfo.sodiumPct = response?["SodiumPct"] as Int
        nutritionInfo.sugar = response?["Sugar"] as Int
        nutritionInfo.totalCalories = response?["TotalCalories"] as Int
        nutritionInfo.totalCarbs = response?["TotalCarbs"] as Int
        nutritionInfo.totalCarbsPct = response?["TotalCarbsPct"] as Int
        nutritionInfo.totalFat = response?["TotalFat"] as Int
        nutritionInfo.totalFatPct = response?["TotalFatPct"] as Int
        nutritionInfo.transFat = response?["TransFat"] as Int
        
        //recipe: Recipe
        nutritionInfo.recipe = recipe
        
        return nutritionInfo
    }

    private func parseIngredient(response: AnyObject, context: DataContext, recipe: Recipe) -> Ingredient {
        let ingredient = dataContext.ingredients.createOrGetFirstEntity(whereAttribute: "recipeId", isEqualTo: recipe.recipeId)
         let ingredientID = NSString(format:"%d", response["IngredientID"] as Int)
        ingredient.displayIndex = response["DisplayIndex"] as Int
        ingredient.ingredientID = ingredientID
        ingredient.recipeId = recipe.recipeId
        ingredient.isHeading = response["IsHeading"] as Int
        ingredient.isLinked = response["IsLinked"] as Int
        ingredient.metricDisplayQuantity = response["MetricDisplayQuantity"] as String
        ingredient.metricQuantity = response["MetricQuantity"] as Int
        ingredient.metricUnit = response["MetricUnit"] as String
        ingredient.name = response["Name"] as String
        ingredient.preparationNotes = (response["PreparationNotes"] is String) ? response["PreparationNotes"] as String : ""
        ingredient.quantity = response["Quantity"] as Int
        ingredient.recipeId = recipe.recipeId
        ingredient.unit = (response["Unit"] is String) ? response["Unit"] as String : ""
        ingredient.displayQuantity = (response["DisplayQuantity"] is String) ? response["DisplayQuantity"] as String : ""
        let ingredientInfo: NSDictionary =  response["IngredientInfo"] as NSDictionary
        ingredient.department = ingredientInfo["Department"] as String
        //recipes
        var recipes = ingredient.recipes.mutableSetValueForKey("recipes")
        recipes.addObject(ingredient)
    
        return ingredient
    }
    
    
    // Closures
    let simpleInterestCalculationClosure = { (loanAmount : Double, var interestRate : Double, years : Int) -> Double in
        interestRate = interestRate / 100.0
        var interest = Double(years) * interestRate * loanAmount
        
        return loanAmount + interest
    }
    
}