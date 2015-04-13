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
    static let ingredientsExplaination = localizedString("ingredientsExplaination", "This recipe contains following ingredients %@, which is similar to your taste and health requirements.")
    static let calaroiesAndExcersiseInfomation = localizedString("calaroiesAndExcersiseInfomation", "It contains %dK calories, In order to burn these calories you have to do exercise around %dmins.")
    static let preferCookingTimeExplaination = localizedString("preferCookingTimeExplaination", "It matches your preferred cooking time %dmins.")
    static let popularRecipeExplaination = localizedString("popularRecipeExplaination", "This recipe is among one of the popular recipes in category of %@. In order to make recommendations, specific to your taste and health please set your preferences.")
    static let preferences = localizedString("Preferences", "Preferences")
    static let cookingTime = localizedString("CookingTime", "Cooking Time")
    static let course = localizedString("Course", "Course")
    static let mins = localizedString("Mins", "mins")
    static let critique = localizedString("Critique", "Critique")
    static let send = localizedString("Send", "Send")
    static let normal = localizedString("Normal", "Normal")
    static let like = localizedString("Like", "Like")
    static let unlike = localizedString("Unlike", "Unlike")
    static let rating = localizedString("Rating", "Rating")
}

func localizedString(key: String, value: String) -> String {
    return NSLocalizedString(key, value:value, comment: "")
    
}