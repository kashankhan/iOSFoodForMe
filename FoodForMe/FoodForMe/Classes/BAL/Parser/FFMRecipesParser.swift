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
    
    
    func parseRecipes(response: AnyObject?, completion: (NSArray?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            var list: [Recipe] = []
            if response is NSArray {
                for recipeInfo in response as NSArray {
                    let recipe: Recipe = self.parseRecipe(recipeInfo, context: backgroundDataContext)!
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
    
     func parseRecipeDetail(response: AnyObject?, completion: (Recipe?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            
            println(response)
            let recipe: Recipe = self.parseRecipe(response!, context: backgroundDataContext)!
            recipe.activeMinutes =  (response?["activeMinutes"] is Int) ? response?["activeMinutes"] as Int : 0
            recipe.recipeDescription = response?["description"] as String
            recipe.primaryIngredient = response?["primaryIngredient"] as String
            recipe.totalMinutes = (response?["totalMinutes"] is Int) ? response?["totalMinutes"] as Int : 0
            recipe.yieldNumber = response?["yieldNumber"] as Int
            recipe.yieldUnit = response?["yieldUnit"] as String
            recipe.instructions = response?["instructions"] as String
            
            //NutritionInfo
            let nutritionInfo: NutritionInfo = self.parseNutritionInfo(response?["nutritionInfo"], context: dataContext, recipe: recipe) as NutritionInfo!
            recipe.nutritionInfo = nutritionInfo
            //Ingredient
            var ingredientSet = NSMutableSet()
            for ingredientsInfo: AnyObject in response?["ingredients"] as Array {
                let ingredient = self.parseIngredient(ingredientsInfo, context: dataContext, recipe: recipe) as Ingredient!
                ingredientSet.addObject(ingredient)
            }
            recipe.ingredients = ingredientSet
            // Save the background data context.
            let (success, error) = backgroundDataContext.save()
            if !success {
                // Replace this implementation with code to handle the error appropriately.
                println("Unresolved error \(error), \(error?.userInfo)")
            }
            
            completion(recipe)
            
        }
    }

    func parseRecommendedRecipes(response: AnyObject, completion: (NSArray?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            var list: [RecommendedRecipe] = []
            if response is NSArray {
                for recommendedRecipeInfo in response as NSArray {
                    let recipeInfo = recommendedRecipeInfo["recipe"] as NSDictionary
                    let recipe: Recipe = self.parseRecipe(recipeInfo, context: backgroundDataContext)!
                    //list.append(recipe)
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
    
    func parseRecipeCategories(response: AnyObject, completion: (NSArray?) -> Void) {
        performInBackground(dataContext) { backgroundDataContext in
            var list: [RecipeCategory] = []
            if response is NSArray {
                for name in response as NSArray {
                    let recipeCategory : RecipeCategory = backgroundDataContext.recipeCategories.createOrGetFirstEntity(whereAttribute: "name", isEqualTo: name)
                    list.append(recipeCategory)
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

    
    private func parseRecipe(response: AnyObject, context: DataContext) -> Recipe? {
        let recipeId = NSString(format:"%d", response["recipeId"] as Int)
        let recipe = context.recipes.createOrGetFirstEntity(whereAttribute: "recipeId", isEqualTo: recipeId)
        println(recipeId);
        recipe.recipeId = recipeId
        recipe.title = response["title"] as String
        recipe.starRating = response["starRating"] as Int
        recipe.totalTries = (response["totalTries"] is Int) ? response["totalTries"] as Bool : 0
        recipe.category = response["category"] as String
        recipe.subcategory = response["subcategory"] as String
        recipe.cuisine = (response["cuisine"] is String) ? response["cuisine"] as String : ""
        recipe.reviewCount = response["reviewCount"] as Int
        recipe.imageUri = response["imageUrl"] as String
        recipe.largeImageUri = response["largeImageUrl"] as String
        return recipe
    }
    
    private func parseNutritionInfo(response: AnyObject?, context: DataContext, recipe: Recipe) -> NutritionInfo? {
        let nutritionInfo = context.nutritions.createEntity()
        nutritionInfo.caloriesFromFat = response?["caloriesFromFat"] as Int
        nutritionInfo.cholesterol = response?["cholesterol"] as Int
        nutritionInfo.cholesterolPct = response?["cholesterolPct"] as Int
        nutritionInfo.dietaryFiber = response?["dietaryFiber"] as Int
        nutritionInfo.dietaryFiberPct = response?["dietaryFiberPct"] as Int
        nutritionInfo.monoFat = response?["monoFat"] as Int
        nutritionInfo.polyFat = response?["polyFat"] as Int
        nutritionInfo.potassium = response?["potassium"] as Int
        nutritionInfo.potassiumPct = response?["potassiumPct"] as Int
        nutritionInfo.protein = response?["protein"] as Int
        nutritionInfo.proteinPct = response?["proteinPct"] as Int
        nutritionInfo.satFat = response?["satFat"] as Int
        nutritionInfo.satFatPct =  (response?["satFatPct"] is Int) ? response?["satFatPct"] as Int : 0
        nutritionInfo.singularYieldUnit = response?["singularYieldUnit"] as String
        nutritionInfo.sodium = response?["sodium"] as Int
        nutritionInfo.sodiumPct = response?["sodiumPct"] as Int
        nutritionInfo.sugar = response?["sugar"] as Int
        nutritionInfo.totalCalories = response?["totalCalories"] as Int
        nutritionInfo.totalCarbs = response?["totalCarbs"] as Int
        nutritionInfo.totalCarbsPct = response?["totalCarbsPct"] as Int
        nutritionInfo.totalFat = response?["totalFat"] as Int
        nutritionInfo.totalFatPct = response?["totalFatPct"] as Int
        nutritionInfo.transFat = (response?["transFat"] is Int) ? response?["transFat"] as Int : 0
        //recipe: Recipe
        nutritionInfo.recipe = recipe
        
        return nutritionInfo
    }

    private func parseIngredient(response: AnyObject, context: DataContext, recipe: Recipe) -> Ingredient {
        let ingredient = context.ingredients.createEntity()
        let ingredientID = NSString(format:"%d", response["ingredientID"] as Int)
        ingredient.displayIndex = response["displayIndex"] as Int
        ingredient.ingredientID = ingredientID
        ingredient.recipeId = recipe.recipeId
        ingredient.isHeading = response["isHeading"] as Int
        ingredient.isLinked = response["isLinked"] as Int
        ingredient.metricDisplayQuantity = response["metricDisplayQuantity"] as String
        ingredient.metricQuantity = response["metricQuantity"] as Int
        ingredient.metricUnit = response["metricUnit"] as String
        ingredient.name = response["name"] as String
        ingredient.preparationNotes = (response["preparationNotes"] is String) ? response["preparationNotes"] as String : ""
        ingredient.quantity = response["quantity"] as Int
        ingredient.recipeId = recipe.recipeId
        ingredient.unit = (response["unit"] is String) ? response["unit"] as String : ""
        ingredient.displayQuantity = (response["displayQuantity"] is String) ? response["displayQuantity"] as String : ""
        if let ingredientInfo: NSDictionary =  response["ingredientInfo"] as? NSDictionary {
            ingredient.department = ingredientInfo["department"] as String
        }
        
        return ingredient
    }
    
    
    // Closures
    let simpleInterestCalculationClosure = { (loanAmount : Double, var interestRate : Double, years : Int) -> Double in
        interestRate = interestRate / 100.0
        var interest = Double(years) * interestRate * loanAmount
        
        return loanAmount + interest
    }
    
}