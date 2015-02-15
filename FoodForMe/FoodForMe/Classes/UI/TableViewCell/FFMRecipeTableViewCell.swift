//
//  FFMRecipeTableViewCell.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FFMRecipeTableViewCell: UITableViewCell {
   
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingStarView: FloatRatingView!
    @IBOutlet weak var avatarimageView: UIImageView!
    
    override func awakeFromNib() {
        avatarimageView.layer.cornerRadius = avatarimageView.frame.size.width / 2
        avatarimageView.clipsToBounds = true
    }
    
    func configureCell(recipe: Recipe) {
        
        self.avatarimageView.image = nil
        self.avatarimageView.loadImage(recipe.imageUri, autoCache: true)
        self.recipeLabel?.text = recipe.title
        self.catagoryLabel?.text = recipe.category + "-" + recipe.subcategory
        self.ratingStarView.rating = recipe.starRating.floatValue
        self.reviewLabel?.text =  NSLS.review + ": " + recipe.reviewCount.stringValue
    }
    
}