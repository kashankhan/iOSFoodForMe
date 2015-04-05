//
//  FFMRecipesBalURLRequest.swift
//  FoodForMe
//
//  Created by Kashan Khan on 03/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class FFMRecipesBalURLRequest : FFMBaseBal {

    enum Router: URLRequestConvertible {
        static let baseUri       =  FFMGlobalConstants.FFMBaseServerUrl + "/recipe"
        static let perPage       = 20
        
        case Search(query: String, page: Int)
        case Recipe(recipeId: String)
        case RateRecipe()
        case PopularRecipes()
        case MyRecommendations(userId: String, category: String)
        case AllRecipeCategories()
        
        // MARK: URLRequestConvertible

        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                    
                case .Search(let query, let page):
                    return ("/searchrecipes", ["keyword": query, "page": page, "resultPerPage" : Router.perPage * page])
                
                case .Recipe(let recipeId):
                    return ("/recipedetail", ["recipeId": recipeId])
                
                case .RateRecipe():
                    return ("/raterecipe", nil)
                    
                case .PopularRecipes():
                    return ("/popularrecipes", ["resultsize": Router.perPage])
                    
                case MyRecommendations(let userId, let category):
                    return ("/myrecommendations", ["userId": userId])
                
                case AllRecipeCategories():
                    return ("/allrecipecategories", nil)
                }
                }()
            
            let uri = Router.baseUri + path
            let URL = NSURL(string: uri)!
            let URLRequest = NSURLRequest(URL: URL)
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
}