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
        configureTableView()
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
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
    // MARK: - Table View
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 60.0
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 0 : 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeDetailTableViewCell"
        var cell: FFMRecipeDetailTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as FFMRecipeDetailTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let recipeCell:FFMRecipeDetailTableViewCell = cell as FFMRecipeDetailTableViewCell
//        let recipe: Recipe = self.fetchedResultsController.objectAtIndexPath(indexPath) as Recipe
        //cell.textLabel!.text = object.valueForKey("title")!.description
        //recipeCell.configureCell(recipe)
        let str = (indexPath.row % 2 == 0) ? "You can initialize an array with an array literal, which is a shorthand way to write one or more values as an array collection. An array literal is written as a list of values, separated by commas, surrounded by a pair of square brackets...You can initialize an array with an array literal, which is a shorthand way to write one or more values as an array collection. An array literal is written as a list of values, separated by commas, surrounded by a pair of square brackets" : "Pappppp"
        recipeCell.titleLabel?.text = str
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