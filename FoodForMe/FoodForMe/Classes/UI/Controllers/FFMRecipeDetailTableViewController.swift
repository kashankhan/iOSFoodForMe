//
//  FFMRecipeDetailTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 15/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FFMRecipeDetailTableViewController: UITableViewController {

    var recipe: Recipe? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    func configureView() {
        fetchRecipe()
    }
    
    func fetchRecipe() {
        if let recipe: Recipe = self.recipe {
            let recipeBal: FFMRecipesBal = FFMRecipesBal()
            recipeBal.getRecipe(recipe.recipeId)
        }

    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let identifierheaderView = "IdentifierFFMRecipeDetailHeaderView"
        var recipeDetailHeaderView: FFMRecipeDetailHeaderView? = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifierheaderView) as? FFMRecipeDetailHeaderView
        if recipeDetailHeaderView == nil {
            let nib: UINib = UINib(nibName: "FFMRecipeDetailHeaderView", bundle: NSBundle.mainBundle())
            tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: identifierheaderView)
            recipeDetailHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifierheaderView) as? FFMRecipeDetailHeaderView
        }
        
        return recipeDetailHeaderView;
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0;
    }
    
}