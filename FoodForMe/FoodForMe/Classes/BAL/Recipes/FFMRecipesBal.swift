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
   
    func getRecipe(recipeId: Int, completion: (Recipe?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.Recipe(recipeId: recipeId)).responseJSON
            { (request, response, data, error) in
                self.recipesParse.parseRecipeDetail(data!, completion: { recipe in
                    completion(recipe)
                })
        }
    }
    
    func getPopularRecipes(completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.PopularRecipes()).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecipes(data, completion: { recipes in
                completion(recipes!)
            })
        }
    }
    
    func rateRecipe(userId: String, recipeId: String, likeIngredints: NSArray, dislikeIngredints: NSArray,  complettion: (NSDictionary?) -> Void) {
        let parameters = ["recipeId":recipeId, "likeIngredints" : likeIngredints, "dislikeIngredints" : dislikeIngredints]
        Alamofire.request(.POST, FFMRecipesBalURLRequest.Router.RateRecipe().URLRequest.URLString, parameters: parameters, encoding:  .JSON).response {(request, response, _, error) in
            println(response)
        }
    }
    
    func getMyRecommendations(userId: String, category: String, completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.MyRecommendations(userId: userId, category: category)).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecommendedRecipes(data!, completion: { recipes in
                completion(recipes!)
            })
        }
    }
    
    func getAllRecipeCategories(completion: (NSArray?) -> Void) {
        Alamofire.request(FFMRecipesBalURLRequest.Router.AllRecipeCategories()).responseJSON { (request, response, data, error) in
            self.recipesParse.parseRecipeCategories(data!, completion: { category in
                completion(category!)
            })
        }
    }
}
