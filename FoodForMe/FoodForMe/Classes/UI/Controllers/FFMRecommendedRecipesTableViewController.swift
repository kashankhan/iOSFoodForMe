//
//  FFMRecommendedRecipiesTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 03/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AlecrimCoreData

class FFMRecommendedRecipesTableViewController : UITableViewController , ENSideMenuDelegate , NSFetchedResultsControllerDelegate {
    
    let recipesBal: FFMRecipesBal = FFMRecipesBal()
    let recipeDal: FFMRecipeDal = FFMRecipeDal()
    var userProfile: UserProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView() {
        self.sideMenuController()?.sideMenu?.delegate = self;
        registerForNotificaitons()
        fetchMyRecommendations()
    }
    
    func fetchMyRecommendations() {
        if userProfile == nil {
            let profileDal: FFMUserProfileDal = FFMUserProfileDal()
            userProfile = profileDal.getUserProfile()
        }
        if let userId =  self.userProfile?.userId {
            var selectedCourse = ""
            if let course: Course = recipeDal.dataContext.courses.filterBy(attribute: "selected", value: 1).first() {
                selectedCourse = course.name
            }
            let cookingTimePreference: CookingTimePreference = recipeDal.dataContext.cookingTimings.filterBy(attribute: "selected", value: true).first()!
            
            let preferCookingTime = cookingTimePreference.time.integerValue

            self.recipesBal.getMyRecommendations(userId, course: selectedCourse, preferCookingTime: preferCookingTime, completion: { recipes in
                self.tableView.reloadData()
            })
        }
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

    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - Notification
    func registerForNotificaitons() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLoginNotification:", name: FFMGlobalConstants.UIFacebookUserDidLoginNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogoutNotification:", name: FFMGlobalConstants.UIFacebookUserDidLogoutNotification, object: nil)
    }
    
    func userDidLoginNotification(notification: NSNotification) {
        if notification.object is UserProfile {
            self.userProfile = notification.object as? UserProfile
        }
    }
    
    func userDidLogoutNotification(notification: NSNotification) {
        self.userProfile = nil
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (tableView == self.searchDisplayController?.searchResultsTableView) ? 1: self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.fetchedResultsController.sections![section]
        var rows = sectionInfo.numberOfEntities
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeTableViewCell"
        var cell: FFMRecipeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as! FFMRecipeTableViewCell
        self.configureCell(tableView, cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(tableView: UITableView, cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let recipeCell: FFMRecipeTableViewCell = cell as! FFMRecipeTableViewCell
        let recommendedRecipe: RecommendedRecipe? = self.fetchedResultsController.entityAtIndexPath(indexPath)
        if let recipe = recommendedRecipe?.recipe {
            recipeCell.configureCell(recipe)
        }
    }
    

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "IdentifierSegueShowRecipeDetail" {
            let tableView: UITableView = ((self.searchDisplayController?.active) == true) ? self.searchDisplayController?.searchResultsTableView : self.tableView
            if let indexPath = tableView.indexPathForSelectedRow() {
                let object = self.fetchedResultsController.entityAtIndexPath(indexPath)
                (segue.destinationViewController as! FFMRecommendedRecipeDetailTableViewController).recommendedRecipe = object
            }
        }
    }
    
    // MARK: - Fetched results controller
    
    
    lazy var fetchedResultsController: FetchedResultsController<RecommendedRecipe> = {
          let recipeDal: FFMRecipeDal = FFMRecipeDal()
        var frc = recipeDal.dataContext.recommendedRecipes.sortBy("recipe.title", ascending: true).toFetchedResultsController()
        if let course: Course = recipeDal.dataContext.courses.filterBy(attribute: "selected", value: 1).first() {
            let predicate: NSPredicate =  NSPredicate(format: "recipe.category contains[c] %@",  course.name)
          frc =  recipeDal.dataContext.recommendedRecipes.filterBy(predicate: predicate).sortBy("recipe.title", ascending: true).toFetchedResultsController()
        }
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