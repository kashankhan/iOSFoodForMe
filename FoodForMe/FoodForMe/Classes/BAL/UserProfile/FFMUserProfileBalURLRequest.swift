//
//  FFMUserProfileBalURLRequest.swift
//  FoodForMe
//
//  Created by Kashan Khan on 08/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import Alamofire

class FFMUserProfileBalURLRequest: NSObject {

    enum Router: URLRequestConvertible {
        static let baseUri       =  FFMGlobalConstants.FFMBaseServerUrl
    
        case saveUserProfile()
        
        // MARK: URLRequestConvertible
        
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                    
                case .saveUserProfile():
                    return ("/userprofile/saveuserprofile", nil)
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