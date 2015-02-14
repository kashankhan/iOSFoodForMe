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
    
    let page          = 1
    
    func searchRecipe(query: String) {
        
        Alamofire.request(BigOvenRecipesBal.Router.Search(query: query, page: page)).response { (request, response, data, error) in
            println("request : \(request)")
            println("response:  \(response)")
            println("error:  \(error)")
            println("data:  \(data)")
        }

    }
    
}