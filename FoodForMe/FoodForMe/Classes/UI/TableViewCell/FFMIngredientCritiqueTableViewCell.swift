//
//  FFMIngredientCritiqueTableViewCell.swift
//  FoodForMe
//
//  Created by Kashan Khan on 08/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMIngredientCritiqueTableViewCell: UITableViewCell {
 
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var unlikeButton: UIButton!
    
    @IBAction func actionLikeButton(sender: AnyObject) {
    
    }
    
    @IBAction func actionUnlikeButton(sender: AnyObject) {
    
    }
    
    func configureCell(object: Dictionary<String, AnyObject>) {
        ingredientLabel.text = object["Name"] as? String
    }
    
}