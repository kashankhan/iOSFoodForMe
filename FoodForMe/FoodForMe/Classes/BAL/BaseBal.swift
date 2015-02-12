//
//  BaseBal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class BaseBal: NSObject {

    func performGetRequest(uri: String, parameters: [String : AnyObject]?) {
        Alamofire.request(.GET, uri, parameters: parameters)
            .response { (request, response, data, error) in
                println(request)
                println(response)
                println(error)
        }
    }
    
}