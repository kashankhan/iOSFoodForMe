//
//  Course.swift
//  FoodForMe
//
//  Created by Kashan Khan on 07/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var selected: NSNumber

}
