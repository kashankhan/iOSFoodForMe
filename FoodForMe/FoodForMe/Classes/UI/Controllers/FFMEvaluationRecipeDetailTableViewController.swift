//
//  FFMEvaluationRecipeDetailTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 03/06/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation

class FFMEvaluationRecipeDetailTableViewController: UITableViewController {
    
    var sectionsTitle: [String] = ["", NSLS.ingredients, NSLS.prepration]
    let sectionsHeight: [CGFloat] = [40.0,  40.0, 40.0]
    
    var recipe: Recipe? {
        didSet {
            // Update the view.
            if let recipName = self.recipe?.title {
                self.sectionsTitle[0] = recipName
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        configureTableView()
        fetchRecipe()
    }
    
    private func fetchRecipe() {
        if let recipe: Recipe = self.recipe {
            if (self.recipe?.valueForKey("instructions") == nil ||
                self.recipe?.valueForKey("ingredients") == nil) {
                    let recipeBal: FFMRecipesBal = FFMRecipesBal()
                    recipeBal.getRecipe(recipe.recipeId, completion: { recipe in
                        self.tableView.reloadData()
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
        if section == 1 &&  objects.count > 0 {
            let ingredient: Ingredient = objects[row] as! Ingredient
            // MetricQuantity + MetricUnit + Name + PreparationNotes
            object  = ingredient.metricDisplayQuantity + " " + ingredient.metricUnit + " " + ingredient.name + " " + ingredient.preparationNotes
        }
        else if section == 2 {
            object = objects[row] as! String
        }
        
        return object
    }
    
    private func objectsInSection(section: Int) -> [AnyObject]{
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
        return sectionsTitle.count
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        let objects = objectsInSection(section)
        if !objects.isEmpty  {
            rows = objects.count
        }
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeDetailTableViewCell"
        var cell: FFMRecipeDetailTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as! FFMRecipeDetailTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let recipeCell:FFMRecipeDetailTableViewCell = cell as! FFMRecipeDetailTableViewCell
        recipeCell.titleLabel?.text = objectAtIndexPath(indexPath) as String
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionsHeight[section]
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel.font = UIFont(name: FFMGlobalConstants.UIAppFontName, size: 18.0)!
        header.textLabel.frame = header.frame
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "IdentifierSegueShowRecipeCritique" {
            (segue.destinationViewController as! FFMRecipeCritiqueTableViewController).recipe = self.recipe
        }
    }

}