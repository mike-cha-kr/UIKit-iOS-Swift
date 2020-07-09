//
//  MemberListCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class MemberListCustomManager: NSObject {
    static var navigationController: UINavigationController? = nil
    
    static func startSample(naviVC: UINavigationController, type: MemberListCustomType?) {
        GlobalSetCustomManager.setDefault()
        
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .customCell:
            cellCustom()
        case .functionOverriding:
            functionOverridingCustom()
        default:
            break
        }
    }
}


extension MemberListCustomManager {
    static func uiComponentCustom() {
        ChannelManager.getSampleChannel { channel in
            let memberListVC = SBUMemberListViewController(channel: channel)
            
            // This part changes the default titleView to a custom view.
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height: 50))
            titleLabel.text = "Custom Title"
            titleLabel.textColor = SBUColorSet.primary500
            memberListVC.titleView = titleLabel
            
            // This part changes the default leftBarButton to a custom leftBarButton. RightButton can also be changed in this way.
            let leftButton = UIButton(type: .custom)
            leftButton.frame = .init(x: 0, y: 0, width: 50, height: 45)
            leftButton.setTitle("Back", for: .normal)
            leftButton.setTitleColor(SBUColorSet.primary300, for: .normal)
            leftButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
            HighlightManager.highlight(leftButton)
            let leftBarButton = UIBarButtonItem(customView: leftButton)
            memberListVC.leftBarButton = leftBarButton
            
            // Move to MemberListViewController using customized components
            self.navigationController?.pushViewController(memberListVC, animated: true)
        }
    }
    
    static func cellCustom() {
        ChannelManager.getSampleChannel { channel in
            let memberListVC = MemberListVC_Cell(channel: channel)
            
            // This part changes the default user cell to a custom cell.
            memberListVC.register(userCell: CustomUserCell())
            
            self.navigationController?.pushViewController(memberListVC, animated: true)
        }
    }
    
    static func functionOverridingCustom() {
        ChannelManager.getSampleChannel { channel in
            // If you inherit `SBUMemberListViewController`, you can customize it by overriding some functions.
            let memberListVC = MemberListVC_Overriding(channel: channel)
            
            self.navigationController?.pushViewController(memberListVC, animated: true)
        }
    }
}


extension MemberListCustomManager {
    @objc static func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
