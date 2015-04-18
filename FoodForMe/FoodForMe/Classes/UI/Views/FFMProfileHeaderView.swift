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
    
    private var userProfile: UserProfile?
    private let dataDal: FFMDefaultDataDal = FFMDefaultDataDal()
    
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
    
        if notification.object is UserProfile {
            userProfile = notification.object as? UserProfile
            self.profilePicView.profileID = userProfile?.userId
            self.nameLabel?.text = userProfile?.name
        }
        else if userProfile != nil {
            dataDal.dataContext.userProfiles.deleteEntity(userProfile!)
        }
    }
}