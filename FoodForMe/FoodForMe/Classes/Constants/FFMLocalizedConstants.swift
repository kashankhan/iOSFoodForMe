//
//  FFMLocalizedConstants.swift
//  FoodForMe
//
//  Created by Kashan Khan on 11/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation

struct NSLS {
    static let settings = localizedString("Settings", "Settings");
    static let recipes  = localizedString("Recipes", "Recipes");
    static let review  = localizedString("Review", "Review");
    static let ingredients  = localizedString("Ingredients", "Ingredients");
    static let prepration  = localizedString("Prepration", "Prepration");
}

func localizedString(key: String, value: String)->String {
    return NSLocalizedString(key, value:value, comment: "");
    
}