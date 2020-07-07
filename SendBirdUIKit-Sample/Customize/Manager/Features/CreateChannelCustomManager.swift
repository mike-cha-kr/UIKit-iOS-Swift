//
//  CreateChannelCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class CreateChannelCustomManager: NSObject {
    static var navigationController: UINavigationController? = nil
    
    static func startSample(naviVC: UINavigationController, type: CreateChannelCustomType?) {
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .customCell:
            cellCustom()
        case .userList:
            userListCustom()
        default:
            break
        }
    }
}


extension CreateChannelCustomManager {
    static func uiComponentCustom() {
        let createChannelVC = SBUCreateChannelViewController()
        
        // This part changes the default titleView to a custom view.
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height: 50))
        titleLabel.text = "Custom Title"
        titleLabel.textColor = SBUColorSet.primary500
        createChannelVC.titleView = titleLabel
        
        // This part changes the default leftBarButton to a custom leftBarButton. RightButton can also be changed in this way.
        let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onClickBack))
        createChannelVC.leftBarButton = leftBarButton
        
        // For custom cell registration, see `cellCustom()` method and `CreateChannelVC` class.
        
        // Move to CreateChannelViewController using customized components
        self.navigationController?.pushViewController(createChannelVC, animated: true)
    }
    
    static func cellCustom() {
        let createChannelVC = CreateChannelVC_Cell()
        
        // This part changes the default user cell to a custom cell.
        createChannelVC.register(userCell: CustomUserCell())
        
        self.navigationController?.pushViewController(createChannelVC, animated: true)
    }
    
    static func userListCustom() {
        let userListQuery = SBDMain.createApplicationUserListQuery()
        userListQuery?.limit = 20
        userListQuery?.loadNextPage(completionHandler: { users, error in
            guard error == nil else { return }
            
            // This is a user list object used for testing.
            guard let users = SBUUserManager.convertUserList(users: users) else { return }
            
            // If you use a list of users who have internally generated relationship data, you can use it as follows:
            // When you're actually using it, include a list of users you're managing directly here.
            let createChannelVC = CreateChannelVC_UserList(users: users)
            
            // Push ViewController after calling the dummy user list.
            createChannelVC.loadDummyUsers {
                self.navigationController?.pushViewController(createChannelVC, animated: true)
            }
        })
    }
}


extension CreateChannelCustomManager {
    @objc static func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
