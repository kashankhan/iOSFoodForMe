//
//  FFMCourseSelectionTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 06/04/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AlecrimCoreData

class FFMCourseSelectionTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    
    func configureView() {
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (tableView == self.searchDisplayController?.searchResultsTableView) ? 1: self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.fetchedResultsController.sections![section]
        var rows = sectionInfo.numberOfObjects
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifierCell = "IdentifierFFMRecipeTableViewCell"
        var cell: FFMRecipeTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as FFMRecipeTableViewCell
        self.configureCell(tableView, cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(tableView: UITableView, cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let identifierCell = "IdentifierDefaultTableViewCell"
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as UITableViewCell
        self.configureCell(tableView, cell: cell, atIndexPath: indexPath)
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