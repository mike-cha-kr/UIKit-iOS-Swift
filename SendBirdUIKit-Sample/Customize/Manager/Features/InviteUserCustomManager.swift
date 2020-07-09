//
//  InviteUserCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class InviteUserCustomManager: NSObject {
    static var navigationController: UINavigationController? = nil
    
    static func startSample(naviVC: UINavigationController, type: InviteUserCustomType?) {
        GlobalSetCustomManager.setDefault()
        
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


extension InviteUserCustomManager {
    static func uiComponentCustom() {
        ChannelManager.getSampleChannel { channel in
            let inviteUserVC = SBUInviteUserViewController(channel: channel)
            
            // This part changes the default titleView to a custom view.
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height: 50))
            titleLabel.text = "Custom Title"
            titleLabel.textColor = SBUColorSet.primary500
            HighlightManager.highlight(titleLabel)
            inviteUserVC.titleView = titleLabel
            
            // This part changes the default leftBarButton to a custom leftBarButton. RightButton can also be changed in this way.
            let leftButton = UIButton(type: .custom)
            leftButton.frame = .init(x: 0, y: 0, width: 50, height: 45)
            leftButton.setTitle("Back", for: .normal)
            leftButton.setTitleColor(SBUColorSet.primary300, for: .normal)
            leftButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
            HighlightManager.highlight(leftButton)
            let leftBarButton = UIBarButtonItem(customView: leftButton)
            inviteUserVC.leftBarButton = leftBarButton
            
            // Move to InviteUserViewController using customized components
            self.navigationController?.pushViewController(inviteUserVC, animated: true)
        }
    }
    
    static func cellCustom() {
        ChannelManager.getSampleChannel { channel in
            let inviteUserVC = InviteUserVC_Cell(channel: channel)
            
            // This part changes the default user cell to a custom cell.
            inviteUserVC.register(userCell: CustomUserCell())
            
            self.navigationController?.pushViewController(inviteUserVC, animated: true)
        }
    }
    
    static func userListCustom() {
        let userListQuery = SBDMain.createApplicationUserListQuery()
        userListQuery?.limit = 20
        userListQuery?.loadNextPage(completionHandler: { users, error in
            guard error == nil else { return }
            
            // This is a user list object used for testing.
            guard let users = SBUUserManager.convertUserList(users: users) else { return }
            
            ChannelManager.getSampleChannel { channel in
                // If you use a list of users who have internally generated relationship data, you can use it as follows:
                // When you're actually using it, include a list of users you're managing directly here.
                let inviteUserVC = InviteUserVC_UserList(channel: channel, users: users)
                
                // Push ViewController after calling the dummy user list.
                inviteUserVC.loadDummyUsers {
                    self.navigationController?.pushViewController(inviteUserVC, animated: true)
                }
            }
        })
    }
}

extension InviteUserCustomManager {
    @objc static func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
