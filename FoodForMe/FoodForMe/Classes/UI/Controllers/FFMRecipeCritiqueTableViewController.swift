//
//  FFMRecipeCritiqueTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 08/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation

class FFMRecipeCritiqueTableViewController: UITableViewController {
   
    let sectionsTitle: [String] = ["", NSLS.ingredients]
    let sectionsHeight: [CGFloat] = [320.0,  40.0]
    var items = [Dictionary<String, AnyObject>]()


    var recipe: Recipe? {
        didSet {
            // Update the view.
            loadItems()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
    private func loadItems() {
        items.removeAll(keepCapacity: true)
        
        if let ingredients:  [Ingredient] = self.recipe?.ingredients.allObjects as? [Ingredient] {
            for ingredient:Ingredient in ingredients {
                items.append(["Name": ingredient.name, "State": "Yo"])
            }
        }
       
    }
    
    private func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        var object: AnyObject = ""
        let section = indexPath.section
        let row = indexPath.row
        let objects = objectsInSection(section)
        if section == 1 &&  objects.count > 0 {
            object = objects[row]
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
     
        return objects
    }
    
    private func numberOfSections() -> Int {
        return sectionsTitle.count
    }
    
    @IBAction func sendRequest(sender: AnyObject) {
        
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
        let identifierCell = "IdentifierFFMIngredientCritiqueTableViewCell"
        var cell: FFMIngredientCritiqueTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifierCell) as FFMIngredientCritiqueTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let recipeCell:FFMIngredientCritiqueTableViewCell = cell as FFMIngredientCritiqueTableViewCell
       // recipeCell.configureCell()
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