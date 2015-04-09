//
//  FFMRecipeRatingTableViewCell.swift
//  FoodForMe
//
//  Created by Kashan Khan on 09/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMRecipeRatingTableViewCell: UITableViewCell, FloatRatingViewDelegate {

    @IBOutlet weak var starRatingView: FloatRatingView!
    typealias RatingDidChangeDelegate = (FFMRecipeRatingTableViewCell, Float) -> ()
    var ratingChange: RatingDidChangeDelegate?
    
    override func awakeFromNib() {
        self.starRatingView.delegate = self
    }
    
    func configureCell(rating: NSNumber) {
        starRatingView.rating = rating.floatValue
    }
    
    // MARK: - Float Rating View
    // 
    /**
    Returns the rating value when touch events end
    */
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        self.ratingChange!(self, rating)
    }
    
    /**
    Returns the rating value as the user pans
    */
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating: Float) {
    
    }
}