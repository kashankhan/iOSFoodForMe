//
//  FFMRecipesParser.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class FFMRecipesParser: FFMBaseParser {
    
    
    
    let parsedRecipes =  { (response: AnyObject) -> [Recipe]? in
        var list: [Recipe] = []
        let recipesDal:FFMRecipesDal = FFMRecipesDal()
        let context: NSManagedObjectContext = recipesDal.backgroundContext!
        if response is NSDictionary {
            for recipeInfo in response["Results"] as NSArray {
                let entityName = "Recipe"
                let recipeId = NSString(format:"%d", recipeInfo["RecipeID"] as Int)
                let predicate = NSPredicate(format:"recipeId = %@", recipeId)
                var recipe = recipesDal.fetchObject(entityName, context: context, predicate: predicate!) as? Recipe
                if recipe == nil {
                    recipe = recipesDal.createManagedObject(entityName, context: context) as? Recipe
                }
                recipe?.recipeId = recipeId
                recipe?.title = recipeInfo["Title"] as String
                recipe?.starRating = recipeInfo["StarRating"] as Int
                recipe?.totalTries = (recipeInfo["TotalTries"] is Int) ? recipeInfo["TotalTries"] as Bool : 0
                recipe?.category = recipeInfo["Category"] as String
                recipe?.subcategory = recipeInfo["Subcategory"] as String
                recipe?.cuisine = (recipeInfo["Cuisine"] is String) ? recipeInfo["Cuisine"] as String : ""
                recipe?.bookmark = (recipeInfo["IsBookmark"] is Bool) ? recipeInfo["IsBookmark"] as Bool : false
                recipe?.reviewCount = recipeInfo["ReviewCount"] as Int
                recipe?.imageUri = recipeInfo["ImageURL"] as String
                recipe?.largeImageUri = recipeInfo["ImageURL120"] as String
                //recipe?.videoUri = recipeInfo["T"] as String
                //recipe?.preparation = recipeInfo["T"] as String
                println(recipe)
                list.append(recipe!)
            
            }
            
            recipesDal.saveContext(context)
        }
       
        return list
    }
    
    
    let parsedRecipe =  { (response: AnyObject) -> Recipe? in
        var recipe: Recipe
        let recipesDal:FFMRecipesDal = FFMRecipesDal()
        let context: NSManagedObjectContext = recipesDal.backgroundContext!
        if response is NSDictionary {
            for recipeInfo in response["Results"] as NSArray {
                let entityName = "Recipe"
                println(recipeInfo)
                println(recipeInfo["RecipeID"])
                let recipeId = NSString(format:"%d", recipeInfo["RecipeID"] as Int)
                let predicate = NSPredicate(format:"recipeId = %@", recipeId)
                var recipe = recipesDal.fetchObject(entityName, context: context, predicate: predicate!) as? Recipe
                if recipe == nil {
                    recipe = recipesDal.createManagedObject(entityName, context: context) as? Recipe
                }
                recipe?.recipeId = recipeId
                recipe?.title = recipeInfo["Title"] as String
                recipe?.starRating = recipeInfo["StarRating"] as Int
                recipe?.totalTries = (recipeInfo["TotalTries"] is Int) ? recipeInfo["TotalTries"] as Bool : 0
                recipe?.category = recipeInfo["Category"] as String
                recipe?.subcategory = recipeInfo["Subcategory"] as String
                recipe?.cuisine = (recipeInfo["Cuisine"] is String) ? recipeInfo["Cuisine"] as String : ""
                recipe?.bookmark = (recipeInfo["IsBookmark"] is Bool) ? recipeInfo["IsBookmark"] as Bool : false
                recipe?.reviewCount = recipeInfo["ReviewCount"] as Int
                recipe?.imageUri = recipeInfo["ImageURL"] as String
                recipe?.largeImageUri = recipeInfo["ImageURL120"] as String
                //recipe?.videoUri = recipeInfo["T"] as String
                //recipe?.preparation = recipeInfo["T"] as String
                println(recipe)
            }
            
            recipesDal.saveContext(context)
        }
        
        return recipe
    }
    
    // Closures
    let simpleInterestCalculationClosure = { (loanAmount : Double, var interestRate : Double, years : Int) -> Double in
        interestRate = interestRate / 100.0
        var interest = Double(years) * interestRate * loanAmount
        
        return loanAmount + interest
    }
    
}