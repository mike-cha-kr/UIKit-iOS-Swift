//
//  ChannelSettingsCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class ChannelSettingsCustomManager: NSObject {
    static var navigationController: UINavigationController? = nil
    
    static func startSample(naviVC: UINavigationController, type: ChannelSettingsCustomType?) {
        GlobalSetCustomManager.setDefault()
        
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .functionOverriding:
            functionOverridingCustom()
        default:
            break
        }
    }
}


extension ChannelSettingsCustomManager {
    static func uiComponentCustom() {
        ChannelManager.getSampleChannel { channel in
            let channelSettingsVC = SBUChannelSettingsViewController(channel: channel)

            // This part changes the default titleView to a custom view.
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height: 50))
            titleLabel.text = "Custom Title"
            titleLabel.textColor = SBUColorSet.primary500
            HighlightManager.highlight(titleLabel)
            channelSettingsVC.titleView = titleLabel
            
            // This part changes the default leftBarButton to a custom leftBarButton. RightButton can also be changed in this way.
            let leftButton = UIButton(type: .custom)
            leftButton.frame = .init(x: 0, y: 0, width: 50, height: 45)
            leftButton.setTitle("Back", for: .normal)
            leftButton.setTitleColor(SBUColorSet.primary300, for: .normal)
            leftButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
            HighlightManager.highlight(leftButton)
            let leftBarButton = UIBarButtonItem(customView: leftButton)
            channelSettingsVC.leftBarButton = leftBarButton
            
            // This part changes the default userInfoView to a custom view.
            let userInfoView = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height:200))
            userInfoView.backgroundColor = SBUColorSet.secondary100
            userInfoView.textAlignment = .center
            userInfoView.text = "Custom UserInfo"
            userInfoView.textColor = SBUColorSet.secondary500
            HighlightManager.highlight(userInfoView)
            channelSettingsVC.userInfoView = userInfoView
            
            // Move to ChannelSettingsViewController using customized components
            self.navigationController?.pushViewController(channelSettingsVC, animated: true)
        }
    }

    static func functionOverridingCustom() {
        ChannelManager.getSampleChannel { channel in
            // If you inherit `SBUChannelSettingsViewController`, you can customize it by overriding some functions.
            let channelSettingsVC = ChannelSettingsVC_Overriding(channel: channel)
            self.navigationController?.pushViewController(channelSettingsVC, animated: true)
        }
    }
}


extension ChannelSettingsCustomManager {
    @objc static func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
