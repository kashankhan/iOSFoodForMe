//
//  Ingredient.swift
//  FoodForMe
//
//  Created by Kashan Khan on 16/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {

    @NSManaged var amount: String
    @NSManaged var name: String
    @NSManaged var displayIndex: NSNumber
    @NSManaged var displayQuantity: NSNumber
    @NSManaged var ingredientID: String
    @NSManaged var department: String
    @NSManaged var isHeading: NSNumber
    @NSManaged var isLinked: NSNumber
    @NSManaged var metricDisplayQuantity: NSNumber
    @NSManaged var metricQuantity: NSNumber
    @NSManaged var metricUnit: String
    @NSManaged var preparationNotes: String
    @NSManaged var quantity: NSNumber
    @NSManaged var unit: String
    @NSManaged var recipeId: String
    @NSManaged var recipes: NSSet

}
