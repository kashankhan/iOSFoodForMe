//
//  RecipeImage.swift
//  FoodForMe
//
//  Created by Kashan Khan on 11/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class RecipeImage: NSManagedObject {

    @NSManaged var uri: String
    @NSManaged var recipe: Recipe

}
