//
//  UserProfile.swift
//  FoodForMe
//
//  Created by Kashan Khan on 10/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class UserProfile: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var userId: String

}
