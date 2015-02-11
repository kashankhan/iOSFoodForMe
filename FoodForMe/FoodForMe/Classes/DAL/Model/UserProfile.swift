//
//  UserProfile.swift
//  FoodForMe
//
//  Created by Kashan Khan on 11/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class UserProfile: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var userId: String
    @NSManaged var email: NSNumber
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var birthday: String
    @NSManaged var gender: String

}
