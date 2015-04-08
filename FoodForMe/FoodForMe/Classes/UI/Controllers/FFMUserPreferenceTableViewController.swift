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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    
    func configureView() {
        insertObjectInItems(NSLS.cookingTime, object: "", segue: "")
        insertObjectInItems(NSLS.ingredients, object: "", segue: "")
        insertObjectInItems(NSLS.course, object: "", segue: "")
    }
    
    private func insertObjectInItems(title: String, object: AnyObject?, segue: String){
        items.append([kTitleKey: title, kObjectKey: object!, kSegueKey: segue])
    }
    
    
    private func objectAtIndexPath(indexPath: NSIndexPath) -> Dictionary<String, AnyObject> {
        var object: String = ""
        return items[indexPath.row]
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
        cell.detailTextLabel?.text = ""
    }
}