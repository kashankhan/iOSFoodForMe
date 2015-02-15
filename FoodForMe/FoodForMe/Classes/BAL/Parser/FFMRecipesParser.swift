//
//  FFMRecipesParser.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation

class FFMRecipesParser: FFMBaseParser {

    
    let parseRecipes = { (recipes: [AnyObject]) -> [AnyObject] in
        
        for recipeObject in recipes {
            
        }
        return []
    }
    // Closures
    let simpleInterestCalculationClosure = { (loanAmount : Double, var interestRate : Double, years : Int) -> Double in
        interestRate = interestRate / 100.0
        var interest = Double(years) * interestRate * loanAmount
        
        return loanAmount + interest
    }
    
}