//
//  RecipeCategory.swift
//  FoodForMe
//
//  Created by Kashan Khan on 04/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class RecipeCategory: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var selected: NSNumber

}
