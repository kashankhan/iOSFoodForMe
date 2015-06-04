//
//  FFMEvaluationRecipeCritiqueTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 04/06/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation

class FFMEvaluationRecipeCritiqueTableViewController: UITableViewController {
    
    let sectionsTitle: [String] = [NSLS.rating]
    let sectionsHeight: [CGFloat] = [40.0]
    var items:NSMutableArray = NSMutableArray()
    var recipeStarRating: NSNumber?
    let recipeBal: FFMRecipesBal = FFMRecipesBal()
    
    var recipe: Recipe? {
        didSet {
            // Update the view.
            loadItems()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
    }
    
    private func loadItems() {
        items.removeAllObjects()
        recipeStarRating = recipe?.starRating
    }
    
    private func objectAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        var object: AnyObject?
        let section = indexPath.section
        let row = indexPath.row
        let objects = objectsInSection(section)
        if  objects.count > 0 {
            object = objects[row]
        }
        return object!
    }
    
    private func objectsInSection(section: Int) -> [AnyObject]{
        var objects:[AnyObject] = []
        objects.append(recipeStarRating!)
        
        return objects
    }
    
    private func numberOfSections() -> Int {
        return sectionsTitle.count
    }
    
    @IBAction func sendRequest(sender: AnyObject) {
        let likeIngredients = filterIngredients(NSLS.like)
        let dislikeIngredients = filterIngredients(NSLS.unlike)
        let recipeRating = recipeStarRating
        let recipeId = recipe?.recipeId
        let profileDal: FFMUserProfileDal = FFMUserProfileDal()
        let userProfile: UserProfile? = profileDal.getUserProfile()
        if let userId = userProfile?.userId  {
            recipeBal.rateRecipe(userId, recipeId: recipeId!, likeIngredients: likeIngredients, dislikeIngredients: dislikeIngredients, completion: { response in
            })
        }
        
    }
    
    private func filterIngredients(param: String) -> [String] {
        var filterList:[String] = []
        for item in self.items {
            let object:Dictionary<String, String> = item as! Dictionary
            if object["State"] == param {
                filterList.append(object["Name"] as String!)
            }
        }
        return filterList
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
        var cell: UITableViewCell?
        cell = self.configureRecipeRatingTableViewCell(tableView, atIndexPath: indexPath) as UITableViewCell
        return cell!
    }
    
    func configureIngredientCritiqueTableViewCell(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMIngredientCritiqueTableViewCell"
        let cell: FFMIngredientCritiqueTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifierCell) as! FFMIngredientCritiqueTableViewCell
        cell.configureCell(objectAtIndexPath(indexPath) as! Dictionary)
        cell.didChange = { ingredientCritiqueTableViewCell, object in
            let indexPath = self.tableView.indexPathForCell(ingredientCritiqueTableViewCell)!
            self.items.replaceObjectAtIndex(indexPath.row, withObject: object)
        }
        return cell
    }
    
    func configureRecipeRatingTableViewCell(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeRatingTableViewCell"
        let cell: FFMRecipeRatingTableViewCell = tableView.dequeueReusableCellWithIdentifier(identifierCell) as! FFMRecipeRatingTableViewCell
        cell.configureCell(objectAtIndexPath(indexPath) as! NSNumber)
        cell.ratingChange = { recipeRatingTableViewCell, rating in
            self.recipeStarRating = rating
        }
        return cell
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
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel.font = UIFont(name: FFMGlobalConstants.UIAppFontName, size: 18.0)!
        header.textLabel.frame = header.frame
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
}
    