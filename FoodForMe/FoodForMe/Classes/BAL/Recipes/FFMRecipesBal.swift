//
//  FFMRecipesBal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 14/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class FFMRecipesBal: FFMBaseBal {
    
    let page = 1
    let recipesParse: FFMRecipesParser = FFMRecipesParser()
    
    func searchRecipe(query: String, completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.Search(query: query, page: page)).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecipes(data!, completion: { recipes in
                completion(recipes!)
            })
        }
    }
   
    func getRecipe(recipeId: String, completion: (Recipe?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.Recipe(recipeId: recipeId)).responseJSON
            { (request, response, data, error) in
                self.recipesParse.parseRecipeDetail(data!, completion: { recipe in
                    completion(recipe)
                })
        }
    }
    
    func getPopularRecipes(course: String, completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.PopularRecipes(course:course)).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecipes(data, completion: { recipes in
                completion(recipes!)
            })
        }
    }
    
    func rateRecipe(userId: String, recipeId: String, likeIngredients: NSArray, dislikeIngredients: NSArray,  completion: (AnyObject?) -> Void) {
        let parameters = ["recipeId":recipeId.toInt()! , "likeIngredients" : likeIngredients, "dislikeIngredients" : dislikeIngredients, "userId": userId]
        Alamofire.request(.POST, FFMRecipesBalURLRequest.Router.RateRecipe().URLRequest.URLString, parameters: parameters, encoding:  .JSON).response {(request, response, _, error) in
            println(response)
            completion(response?)
        }
    }
    
    func getMyRecommendations(userId: String, course: String, preferCookingTime: Int, completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.MyRecommendations(userId: userId, course: course, preferCookingTime: preferCookingTime)).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecommendedRecipes(data, completion: { recommendedRecipes in
                completion(recommendedRecipes!)
            })
        }
    }
    
    func getAllRecipeCategories(completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.AllCourses()).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecipeCategories(data, completion: { category in
                completion(category!)
            })
        }
    }
}
