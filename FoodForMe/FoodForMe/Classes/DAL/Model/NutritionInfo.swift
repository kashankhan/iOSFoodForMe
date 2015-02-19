//
//  NutritionInfo.swift
//  FoodForMe
//
//  Created by Kashan Khan on 19/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class NutritionInfo: NSManagedObject {

    @NSManaged var caloriesFromFat: NSNumber
    @NSManaged var cholesterol: NSNumber
    @NSManaged var cholesterolPct: NSNumber
    @NSManaged var dietaryFiber: NSNumber
    @NSManaged var dietaryFiberPct: NSNumber
    @NSManaged var monoFat: NSNumber
    @NSManaged var polyFat: NSNumber
    @NSManaged var potassium: NSNumber
    @NSManaged var potassiumPct: NSNumber
    @NSManaged var protein: NSNumber
    @NSManaged var proteinPct: NSNumber
    @NSManaged var satFat: NSNumber
    @NSManaged var satFatPct: NSNumber
    @NSManaged var singularYieldUnit: String
    @NSManaged var sodium: NSNumber
    @NSManaged var sodiumPct: NSNumber
    @NSManaged var sugar: NSNumber
    @NSManaged var totalCalories: NSNumber
    @NSManaged var totalCarbs: NSNumber
    @NSManaged var totalCarbsPct: NSNumber
    @NSManaged var totalFat: NSNumber
    @NSManaged var totalFatPct: NSNumber
    @NSManaged var transFat: NSNumber
    @NSManaged var recipeId: String
    @NSManaged var recipe: FoodForMe.Recipe

}
