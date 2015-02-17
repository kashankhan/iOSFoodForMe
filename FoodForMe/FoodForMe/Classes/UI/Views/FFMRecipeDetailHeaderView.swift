//
//  FFMRecipeDetailHeaderView.swift
//  FoodForMe
//
//  Created by Kashan Khan on 17/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMRecipeDetailHeaderView : UITableViewHeaderFooterView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ratingStarView: FloatRatingView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeCatagoryLabel: UILabel!
    
    func configureView(recipe: Recipe) {
        
        self.avatarImageView.image = nil
        self.avatarImageView.loadImage(recipe.imageUri, autoCache: true)
        self.recipeTitleLabel?.text = recipe.title
        self.recipeTitleLabel?.text = recipe.category + "-" + recipe.subcategory
        self.ratingStarView.rating = recipe.starRating.floatValue
    }
}