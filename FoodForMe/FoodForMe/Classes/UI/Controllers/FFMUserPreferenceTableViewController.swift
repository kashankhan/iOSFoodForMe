//
//  FFMUserPreferenceTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 06/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMUserPreferenceTableViewController: UITableViewController {

    var items = [Dictionary<String, AnyObject>]()
    let kTitleKey = "Title Key"
    let kObjectKey = "Object Key"
    let kSegueKey = "Segue Key"
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView() {
        items.removeAll(keepCapacity: true)
        let cookingTimePreference: CookingTimePreference = dataContext.cookingTimings.filterBy(attribute: "selected", value: true).first()!
        var value: String = NSString(format:"%@ %@", cookingTimePreference.time, NSLS.mins)
        insertObjectInItems(NSLS.cookingTime, object: value, segue: "IdentifierSegueShowPerferCookingTimeSelection")
        
       // insertObjectInItems(NSLS.ingredients, object: "", segue: "")
        
        value = ""
        if let course: Course = dataContext.courses.filterBy(attribute: "selected", value: 1).first() {
            value = course.name
        }
        insertObjectInItems(NSLS.course, object: value, segue: "IdentifierSegueShowCourseSelection")
        self.tableView.reloadData()
    }
    
    private func insertObjectInItems(title: String, object: AnyObject?, segue: String){
        items.append([kTitleKey: title, kObjectKey: object!, kSegueKey: segue])
    }
    
    
    private func objectAtIndexPath(indexPath: NSIndexPath) -> Dictionary<String, AnyObject> {
        var object: String = ""
        return items[indexPath.row]
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
    
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierDefaultTableViewCell"
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as UITableViewCell
        self.configureCell(tableView, cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(tableView: UITableView, cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = objectAtIndexPath(indexPath) as Dictionary
        cell.textLabel?.text = object[kTitleKey] as? String
        cell.detailTextLabel?.text = object[kObjectKey] as? String
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = objectAtIndexPath(indexPath) as Dictionary
        performSegueWithIdentifier(object[kSegueKey] as? String, sender: self)
    }
}