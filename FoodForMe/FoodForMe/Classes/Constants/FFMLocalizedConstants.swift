//
//  FFMLocalizedConstants.swift
//  FoodForMe
//
//  Created by Kashan Khan on 11/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation

struct NSLS {
    static let settings = localizedString("Settings", "Settings")
    static let recipes  = localizedString("Recipes", "Recipes")
    static let review  = localizedString("Review", "Review")
    static let ingredients  = localizedString("Ingredients", "Ingredients")
    static let prepration  = localizedString("Prepration", "Prepration")
    static let recommendations = localizedString("Recommendations", "Recommendations")
    static let popularRecipes = localizedString("PopularRecipes", "Popular Recipes")
    static let explaination = localizedString("Explaination", "Explaination")
    static let ingredientsExplaination = localizedString("ingredientsExplaination", "This recipe contains following indegredinets %@, which is similar to your taste and health requirments.")
    static let calaroiesAndExcersiseInfomation = localizedString("calaroiesAndExcersiseInfomation", "It containts %d K caloaries, Inorder to burn these calaroies you have to do excersise around %d min.")
    static let preferCookingTimeExplaination = localizedString("preferCookingTimeExplaination", "It matches your perfer cooking time %@ min")
    static let popularRecipeExplaination = localizedString("popularRecipeExplaination", "This recipe is among one of popular recipe in catagoy of %@. In order to make recommendation specific to you taste and health please set your preference")
    static let preferences = localizedString("Preferences", "Preferences")
    static let cookingTime = localizedString("CookingTime", "Cooking Time")
    static let course = localizedString("Course", "Course")
    static let mins = localizedString("Mins", "mins")
}

func localizedString(key: String, value: String)->String {
    return NSLocalizedString(key, value:value, comment: "")
    
}