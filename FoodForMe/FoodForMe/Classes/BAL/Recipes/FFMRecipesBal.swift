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
    
    func searchRecipe(query: String) {
        Alamofire.request(BigOvenRecipesBal.Router.Search(query: query, page: page)).responseJSON { (request, response, data, error) in
            println(response)
            println(data)
            self.recipesParse.parsedRecipes(data!)
        }
    }
   
    func getRecipe(recipeId: String) {
        Alamofire.request(BigOvenRecipesBal.Router.Recipe(recipeId: recipeId)).responseJSON { (request, response, data, error) in
            println(data)
        }
    }
}
