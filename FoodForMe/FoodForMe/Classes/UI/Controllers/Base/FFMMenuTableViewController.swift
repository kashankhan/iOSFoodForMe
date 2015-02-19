//
//  FFMMenuTableViewController.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMMenuTableViewController: UITableViewController, FBLoginViewDelegate {
    var selectedMenuItem : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel?.text = "ViewController #\(indexPath.row+1)"
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("FFMRecipiesTableViewController") as FFMRecipiesTableViewController
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
            break
        }
        sideMenuController()?.setContentViewController(destViewController)

    }
    
     override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let identifierheaderView = "IdentifierFFMProfileHeaderView"
        var profileHeaderView: FFMProfileHeaderView? = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifierheaderView) as? FFMProfileHeaderView
        if profileHeaderView == nil {
            let nib: UINib = UINib(nibName: "FFMProfileHeaderView", bundle: NSBundle.mainBundle())
            tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: identifierheaderView)
            profileHeaderView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifierheaderView) as? FFMProfileHeaderView

        }

        return profileHeaderView;
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.0;
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 75
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.frame), 50))
        var loginView: FBLoginView = FBLoginView()
        loginView.frame.size.width = CGRectGetWidth(tableView.frame) * 0.95
        loginView.frame = CGRectOffset(loginView.frame, (tableView.center.x - (loginView.frame.size.width / 2)), 5)
        loginView.readPermissions = ["public_profile", "email", "user_friends"];
        loginView.delegate = self
        footerView.addSubview(loginView)
        
        return footerView;
        
    }
    
    // Mark: Facebook
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        NSNotificationCenter.defaultCenter().postNotificationName(FFMGlobalConstants.UIFacebookUserDidLoginNotification, object: user)
//        let profileDal: FFMUserProfileDal =  FFMUserProfileDal()
//        profileDal.saveFacebookProfile(user, completion: { userProfile in
//            
//        })
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        NSNotificationCenter.defaultCenter().postNotificationName(FFMGlobalConstants.UIFacebookUserDidLogoutNotification, object: nil)
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/
}