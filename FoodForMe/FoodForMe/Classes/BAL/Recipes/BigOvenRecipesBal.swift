//
//  BigOvenRecipesBal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 14/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class BigOvenRecipesBal: FFMBaseBal {
    
    enum Router: URLRequestConvertible {
//APi key select any
//        dvx3yd92dN1feo7ywI9bT5M50708VrCq	
//        dvx1Q4Ts9FUt8zZorr2KXO1u0s3wCU0i
//        dvxYzGm1S642ur3foOj587frkxR5xOI0
        
        
        static let baseUri       = "http://api.bigoven.com"
        static let apiKey        = "dvxYzGm1S642ur3foOj587frkxR5xOI0"
        static let perPage       = 20
        //http://api.bigoven.com/recipes?title_kw=oysters&pg=1&rpp=20&api_key={your-api-key}
       
        case Search(query: String, page: Int)
        case Recipe(recipeId: String)
        
        // MARK: URLRequestConvertible
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                case .Search(let query, let page):
                    return ("/recipes", ["title_kw": query, "pg": page, "rpp": Router.perPage, "api_key": Router.apiKey])
                case .Recipe(let recipeId):
                    return ("/recipe/" + recipeId, ["api_key": Router.apiKey])
                }
                }()
            let uri = Router.baseUri + path
            let url = NSURL(string: uri)!
            
            
            var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(request, parameters: parameters).0
        }
    }
}