//
//  FFMDefaultDataDal.swift
//  FoodForMe
//
//  Created by Kashan Khan on 08/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import AlecrimCoreData

class FFMDefaultDataDal: FFMBaseDal {

    let recipesBal: FFMRecipesBal = FFMRecipesBal()
    
    func loadDefaultData() {
        loadCategories()
        loadPreferCookingTimings()
    }
    
    private func loadCategories() {
        self.recipesBal.getAllRecipeCategories({ catagories in
            performInBackground(self.dataContext) { backgroundDataContext in
                var course: Course? = backgroundDataContext.courses.filterBy(attribute: "selected", value: 1).first()
                if course == nil {
                  course = backgroundDataContext.courses.filterBy(attribute: "name", value: "Any").first()
                    course?.selected = true
                }
                
                // Save the background data context.
                let (success, error) = backgroundDataContext.save()
                if !success {
                    // Replace this implementation with code to handle the error appropriately.
                    println("Unresolved error \(error), \(error?.userInfo)")
                    
                }
            }

        })
    }
    
    private func loadPreferCookingTimings() {
        var cookingTimePreference: CookingTimePreference? = dataContext.cookingTimings.filterBy(attribute: "selected", value: 1).first()
        if cookingTimePreference == nil {
            performInBackground(dataContext) { backgroundDataContext in
                let interval = 15
                for index in 1...10 {
                    cookingTimePreference = backgroundDataContext.cookingTimings.createEntity()
                    cookingTimePreference?.time = index * interval
                    if (index == 10) {
                        cookingTimePreference?.selected = true
                    }
                }
            
                // Save the background data context.
                let (success, error) = backgroundDataContext.save()
                if !success {
                    // Replace this implementation with code to handle the error appropriately.
                    println("Unresolved error \(error), \(error?.userInfo)")
                    
                }
            }
        }
    }
}