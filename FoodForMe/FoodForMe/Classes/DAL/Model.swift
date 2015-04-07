//
//  Model.swift
//  FoodForMe
//
//  Created by Kashan Khan on 07/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class Model: NSManagedObject {

    @NSManaged var time: NSNumber
    @NSManaged var userProfile: UserProfile

}
