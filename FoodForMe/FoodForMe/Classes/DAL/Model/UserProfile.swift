//
//  UserProfile.swift
//  FoodForMe
//
//  Created by Kashan Khan on 16/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import CoreData

class UserProfile: NSManagedObject {

    @NSManaged var birthday: String
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var gender: String
    @NSManaged var lastName: String
    @NSManaged var name: String
    @NSManaged var profileLink: String
    @NSManaged var userId: String

}
