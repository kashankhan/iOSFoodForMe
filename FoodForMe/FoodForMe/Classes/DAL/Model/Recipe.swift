//
//  Recipe.swift
//  FoodForMe
//
//  Created by Kashan Khan on 11/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Recipe: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var preparation: String
    @NSManaged var starts: NSNumber
    @NSManaged var videoUri: String
    @NSManaged var images: NSManagedObject
    @NSManaged var ingredients: NSManagedObject

}
