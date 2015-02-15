//
//  FFMRecipiesTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMRecipiesTableViewController: UITableViewController , ENSideMenuDelegate {
    
    let identifierCell = "IdentifierFFMRecipeTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // MARK: - Private Methods
    func configureViews() {
        self.sideMenuController()?.sideMenu?.delegate = self;
        registerNibs()
        
        let recipesBal = FFMRecipesBal()
        recipesBal.searchRecipe("oysters")
        
    }
    
    func registerNibs() {
        let nib: UINib = UINib(nibName: "FFMRecipeTableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: identifierCell)
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: FFMRecipeTableViewCell  = tableView.dequeueReusableCellWithIdentifier(identifierCell, forIndexPath: indexPath) as FFMRecipeTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: FFMRecipeTableViewCell, atIndexPath indexPath: NSIndexPath) {
//        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
//        cell.textLabel!.text = object.valueForKey("name")!.description
        cell.configureCell()
    }
}