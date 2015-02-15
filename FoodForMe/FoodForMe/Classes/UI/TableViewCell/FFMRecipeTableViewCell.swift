//
//  FFMRecipeTableViewCell.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

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
    
    func configureCell() {
    
    }
    
}