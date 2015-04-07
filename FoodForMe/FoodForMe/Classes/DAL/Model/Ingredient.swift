//
//  Ingredient.swift
//  FoodForMe
//
//  Created by Kashan Khan on 07/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {

    @NSManaged var department: String
    @NSManaged var displayIndex: NSNumber
    @NSManaged var displayQuantity: String
    @NSManaged var ingredientId: String
    @NSManaged var isHeading: NSNumber
    @NSManaged var isLinked: NSNumber
    @NSManaged var metricDisplayQuantity: String
    @NSManaged var metricQuantity: NSNumber
    @NSManaged var metricUnit: String
    @NSManaged var name: String
    @NSManaged var preparationNotes: String
    @NSManaged var quantity: NSNumber
    @NSManaged var recipeId: String
    @NSManaged var unit: String
    @NSManaged var recipes: NSSet

}
