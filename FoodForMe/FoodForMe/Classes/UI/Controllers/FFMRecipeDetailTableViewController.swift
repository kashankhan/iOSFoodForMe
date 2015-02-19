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

    let sectionsTitle: [String] = ["", NSLS.ingredients, NSLS.prepration]
    let sectionsHeight: [CGFloat] = [320.0,  40.0, 40.0]
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
//            recipeBal.getRecipe(recipe.recipeId, completion: { recipe in
//                println(recipe?.recipeId)
//            })
        }
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeTableViewCell"
        var cell: FFMRecipeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as FFMRecipeTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let recipeCell:FFMRecipeTableViewCell = cell as FFMRecipeTableViewCell
//        let recipe: Recipe = self.fetchedResultsController.objectAtIndexPath(indexPath) as Recipe
        //cell.textLabel!.text = object.valueForKey("title")!.description
        //recipeCell.configureCell(recipe)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var recipeDetailHeaderView: FFMRecipeDetailHeaderView?
        
        if section == 0 {
            let identifierheaderView = "IdentifierFFMRecipeDetailHeaderView"
            recipeDetailHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifierheaderView) as? FFMRecipeDetailHeaderView
            if recipeDetailHeaderView == nil {
                let nib: UINib = UINib(nibName: "FFMRecipeDetailHeaderView", bundle: NSBundle.mainBundle())
                tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: identifierheaderView)
                recipeDetailHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifierheaderView) as? FFMRecipeDetailHeaderView
            }
            recipeDetailHeaderView?.configureView(self.recipe!)
        }

        return recipeDetailHeaderView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionsHeight[section]
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as UITableViewHeaderFooterView
        header.textLabel.font = UIFont(name: FFMGlobalConstants.UIAppFontName, size: 18.0)!
        header.textLabel.frame = header.frame
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
    
}