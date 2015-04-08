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
 
    var lastSelectedIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Methods
    private func selectCourseAtIndexPath(indexPath: NSIndexPath?, tableView: UITableView, select: Bool) {
        var course: Course?
        if (indexPath != nil) {
            course = self.fetchedResultsController.entityAtIndexPath(indexPath!)
            course?.selected = select
            let cell: UITableViewCell =  tableView.cellForRowAtIndexPath(indexPath!)!
            cell.accessoryType = select ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        }
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
        let identifierCell = "IdentifierDefaultTableViewCell"
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(identifierCell) as UITableViewCell
        self.configureCell(tableView, cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectCourseAtIndexPath(lastSelectedIndexPath, tableView: tableView, select: false)
        selectCourseAtIndexPath(indexPath, tableView: tableView, select: true)
        lastSelectedIndexPath = indexPath
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCell(tableView: UITableView, cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let course: Course = self.fetchedResultsController.entityAtIndexPath(indexPath)
        cell.textLabel?.text = course.name
        cell.accessoryType = course.selected.boolValue ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        if course.selected.boolValue {
            lastSelectedIndexPath = indexPath
        }
    }
    
    // MARK: - Fetched results controller
    
    
    lazy var fetchedResultsController: FetchedResultsController<Course> = {
        let frc = dataContext.courses.orderByAscending("name").toFetchedResultsController()
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