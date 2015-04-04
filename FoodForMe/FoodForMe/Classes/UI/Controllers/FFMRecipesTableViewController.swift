//
//  FFMRecipiesTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AlecrimCoreData

class FFMRecipesTableViewController: UITableViewController , ENSideMenuDelegate , NSFetchedResultsControllerDelegate, UISearchControllerDelegate, UISearchBarDelegate {
    
    let recipesBal: FFMRecipesBal = FFMRecipesBal()
    var searchResult: NSArray? = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - Private Methods
    
    func configureView() {
        self.sideMenuController()?.sideMenu?.delegate = self;
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true;
    }
    
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (tableView == self.searchDisplayController?.searchResultsTableView) ? 1: self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.fetchedResultsController.sections![section]
        var rows = sectionInfo.numberOfObjects
        if tableView == self.searchDisplayController?.searchResultsTableView {
            rows = (searchResult != nil) ? searchResult!.count : 0
        }
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeTableViewCell"
        var cell: FFMRecipeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as FFMRecipeTableViewCell
        self.configureCell(tableView, cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(tableView: UITableView, cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {

        let recipeCell: FFMRecipeTableViewCell = cell as FFMRecipeTableViewCell
        let recipe: Recipe = (tableView == self.searchDisplayController?.searchResultsTableView) ?
        self.searchResult?.objectAtIndex(indexPath.row) as Recipe : self.fetchedResultsController.entityAtIndexPath(indexPath)
        recipeCell.configureCell(recipe)
    }
    
    // MARK: - Search Bar
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        weak var recipesTableViewController: FFMRecipesTableViewController? = self
        recipesBal.searchRecipe(searchBar.text, completion: { recipes in
            if (recipes?.count > 0) {
                recipesTableViewController?.searchResult = recipes
                if (recipesTableViewController?.searchDisplayController?.active == true) {
                    recipesTableViewController?.searchDisplayController?.searchResultsTableView.reloadData()
                }
            }
        })
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "IdentifierSegueShowRecipeDetail" {
            let tableView: UITableView = ((self.searchDisplayController?.active) == true) ? self.searchDisplayController?.searchResultsTableView : self.tableView
            if let indexPath = tableView.indexPathForSelectedRow() {
                let object =  ((self.searchDisplayController?.active) == true) ?
                    self.searchResult?.objectAtIndex(indexPath.row) as Recipe :self.fetchedResultsController.entityAtIndexPath(indexPath)
                (segue.destinationViewController as FFMRecipeDetailTableViewController).recipe = object
            }
        }
    }
    
    // MARK: - Fetched results controller
    
    
    lazy var fetchedResultsController: FetchedResultsController<Recipe> = {
        let frc = dataContext.recipes.orderByAscending("title").toFetchedResultsController()
        frc.bindToTableView(self.tableView)
        
        return frc
        }()
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(self.tableView, cell: tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
}