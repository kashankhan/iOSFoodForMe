//
//  FFMRecipeRatingTableViewCell.swift
//  FoodForMe
//
//  Created by Kashan Khan on 09/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMRecipeRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var starRatingView: FloatRatingView!
    
    func configureCell(rating: NSNumber) {
        starRatingView.rating = rating.floatValue
    }
}