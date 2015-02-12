//
//  FFMProfileHeaderView.swift
//  FoodForMe
//
//  Created by Kashan Khan on 12/02/2015.
//  Copyright (c) 2015 Kashan Khan. All rights reserved.
//

import Foundation
import UIKit

class FFMProfileHeaderView : UITableViewHeaderFooterView {

    @IBOutlet weak var profilePicView: FBProfilePictureView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        profilePicView.layer.cornerRadius = profilePicView.frame.size.width / 2
        profilePicView.clipsToBounds = true
        
        registerForNotificaitons()
    }
    
    func registerForNotificaitons() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUserInfo:", name: FFMGlobalConstants.UIFacebookUserDidLoginNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setUserInfo:", name: FFMGlobalConstants.UIFacebookUserDidLogoutNotification, object: nil)
    }
    
    func setUserInfo(notification: NSNotification) {
        self.profilePicView.profileID = nil
        self.nameLabel?.text = ""
        if (notification.object is FBGraphUser) {
            
            var user: FBGraphUser = notification.object as FBGraphUser
            self.profilePicView.profileID = user.objectID
            self.nameLabel?.text = user.name
        }
    }
}