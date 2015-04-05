//
//  FFMRecommendedRecipeDetailTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 04/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AlecrimCoreData

class FFMRecommendedRecipeDetailTableViewController: UITableViewController {
    
    let sectionsTitle: [String] = ["", NSLS.ingredients, NSLS.prepration]
    let sectionsHeight: [CGFloat] = [320.0,  40.0, 40.0]
    
    var recipe: Recipe? {
        didSet {
            // Update the view.
            self.tableView.reloadData()
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
    
    private func fetchRecipe() {
        if let recipe: Recipe = self.recipe {
            if (self.recipe?.valueForKey("instructions") == nil || self.recipe?.valueForKey("ingredients") == nil) {
                let recipeBal: FFMRecipesBal = FFMRecipesBal()
                recipeBal.getRecipe(recipe.recipeId, completion: { recipe in
                    self.recipe = recipe
                })
            }
        }
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
    private func objectAtIndexPath(indexPath: NSIndexPath) -> String {
        var object: String = ""
        let section = indexPath.section
        let row = indexPath.row
        let objects = objectsInSection(section)
        
        println(objects)
        
        if !objects.isEmpty {
            if section == 1 && !objects.isEmpty {
                let ingredient: Ingredient = objects[row] as Ingredient
                //               MetricQuantity + MetricUnit + Name + PreparationNotes
                object  = ingredient.metricDisplayQuantity + " " + ingredient.metricUnit + " " + ingredient.name + " " + ingredient.preparationNotes
            }
            else if section == 2 {
                object = objects[row] as String
            }
        }
        return object
    }
    
    private func objectsInSection(section: Int) -> [AnyObject] {
        var objects:[AnyObject] = []
        if section == 1 {
            if let ingredients = self.recipe?.ingredients.allObjects {
                objects = ingredients
            }
        }
        else if (section == 2 && self.recipe?.valueForKey("instructions") != nil) {
            let recipeDescription: AnyObject? = self.recipe?.instructions
            objects.append(recipeDescription!)
        }
        return objects
        
    }
    
    private func numberOfSections() -> Int {
        var sections: Int = 1
        for index in 0...2 {
            let objects = objectsInSection(index)
            if !objects.isEmpty {
                sections++
            }
        }
        return sections
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsInSection(section).count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeDetailTableViewCell"
        var cell: FFMRecipeDetailTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as FFMRecipeDetailTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let recipeCell:FFMRecipeDetailTableViewCell = cell as FFMRecipeDetailTableViewCell
        recipeCell.titleLabel?.text = objectAtIndexPath(indexPath) as String
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