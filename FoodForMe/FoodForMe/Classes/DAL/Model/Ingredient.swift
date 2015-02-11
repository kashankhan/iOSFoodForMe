//
//  Ingredient.swift
//  FoodForMe
//
//  Created by Kashan Khan on 11/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Ingredient: NSManagedObject {

    @NSManaged var amount: String
    @NSManaged var name: String
    @NSManaged var recipes: NSSet

}
