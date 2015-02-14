//
//  YummlyRecipesBal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 14/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class YummlyRecipesBal: FFMBaseBal {

    enum Router: URLRequestConvertible {
        static let baseUri       = "https://api.yummly.com/v1"
        static let appId         = "dacc51f5"
        static let apiKey        = "2c3567467888149bfb885132e386c30b"
        static let perPage       = 25
        
        case Search(query: String, page: Int)
        
        // MARK: URLRequestConvertible
        
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                case .Search(let query, let page) where page > 1:
                    return ("/recipes", ["q": query, "offset": Router.perPage * page])
                case .Search(let query, _):
                    return ("/search", ["q": query])
                }
                }()
            let uri = Router.baseUri + path + Router.baseUri
            let URL = NSURL(string: uri)!
            let URLRequest = NSURLRequest(URL: URL)
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
}