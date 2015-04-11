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
    typealias DidChangeDelegate = (FFMIngredientCritiqueTableViewCell, Dictionary<String, String>) -> ()
    var didChange: DidChangeDelegate?
    
    let stateKey = "State"
    let nameKey = "Name"
    
    @IBAction func actionLikeButton(sender: UIButton) {
        changeButtonState(sender, secondaryButton: unlikeButton)
        valueDidChange(getButtonStatus(sender))
    }
    
    @IBAction func actionUnlikeButton(sender: UIButton) {
        changeButtonState(sender, secondaryButton: likeButton)
        valueDidChange(getButtonStatus(sender))
    }
    
    func configureCell(object: Dictionary<String, String>) {
        ingredientLabel.text = object[nameKey]
        let state: String = object[stateKey] as String!
        if state == NSLS.like {
            likeButton.selected = true
        }
        else if state == NSLS.unlike {
            unlikeButton.selected = true
        }
    }
    
    private func valueDidChange(value: String) {
        let object = [nameKey: ingredientLabel.text!, stateKey: value]
        self.didChange!(self, object)
    }
    
    private func changeButtonState(mainButton: UIButton, secondaryButton: UIButton) {
        mainButton.selected = !mainButton.selected
        if mainButton.selected {
            secondaryButton.selected = false
        }
    }
    
    private func getButtonStatus(button: UIButton) -> String {
        var status = NSLS.normal
        if button.selected {
            status = (button == likeButton) ? NSLS.like : NSLS.unlike
        }
        return status
    }
    
}