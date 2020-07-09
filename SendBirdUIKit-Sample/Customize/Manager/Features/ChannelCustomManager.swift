//
//  ChannelCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class ChannelCustomManager: NSObject {
    static var navigationController: UINavigationController? = nil
    
    static func startSample(naviVC: UINavigationController, type: ChannelCustomType?) {
        GlobalSetCustomManager.setDefault()
        
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .customCell:
            cellCustom()
        case .messageListParams:
            messageListParamsCustom()
        case .messageParams:
            messageParamsCustom()
        case .functionOverriding:
            functionOverridingCustom()
        default:
            break
        }
    }
}


extension ChannelCustomManager {
    static func uiComponentCustom() {
        ChannelManager.getSampleChannel { channel in
            let channelVC = SBUChannelViewController(channel: channel)
            
            // This part changes the default titleView to a custom view.
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height: 50))
            titleLabel.text = "Custom Title"
            titleLabel.textColor = SBUColorSet.primary500
            HighlightManager.highlight(titleLabel)
            channelVC.titleView = titleLabel
            
            // This part changes the default leftBarButton to a custom leftBarButton. RightButton can also be changed in this way.
            let leftButton = UIButton(type: .custom)
            leftButton.frame = .init(x: 0, y: 0, width: 50, height: 45)
            leftButton.setTitle("Back", for: .normal)
            leftButton.setTitleColor(SBUColorSet.primary300, for: .normal)
            leftButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
            HighlightManager.highlight(leftButton)
            let leftBarButton = UIBarButtonItem(customView: leftButton)
            channelVC.leftBarButton = leftBarButton
            
            // This part changes the messageInfoButton of newMessageInfoView.
            // TODO:
            let newMessageInfoView = SBUNewMessageInfo()
            newMessageInfoView.messageInfoButton = UIButton(type: .custom)
            channelVC.newMessageInfoView = newMessageInfoView
                        
            // This part changes the default emptyView to a custom emptyView.
            let emptyView = CustomEmptyView()
            HighlightManager.highlight(emptyView)
            channelVC.emptyView = emptyView
            
            // Move to ChannelViewController using customized components
            self.navigationController?.pushViewController(channelVC, animated: true)
        }
    }
    
    static func cellCustom() {
        // See the messageParamsCustom() function.
        self.messageParamsCustom()
    }
    
    static func messageListParamsCustom() {
        ChannelManager.getSampleChannel { channel in
            // You can customize the message list using your own MessageListParams.
            // For all params options, refer to the `SBDMessageListParams` class.
            let params = SBDMessageListParams()
            params.includeMetaArray = true
            params.includeReactions = true
            params.includeReplies = true
            params.messageType = .user
            // ... You can set more query options
            
            // This part initialize the message list with your own MessageListParams.
            let channelVC = SBUChannelViewController(channel: channel, messageListParams: params)
            
            // Move to the ChannelViewController created using MessageListParams.
            self.navigationController?.pushViewController(channelVC, animated: true)
        }
    }

    // This is a sample displaying a highlight message using MessageParams.
    static func messageParamsCustom() {
        ChannelManager.getSampleChannel { channel in
            let channelVC = ChannelVC(channel: channel)
            
            // This part changes the default user message cell to a custom cell.
            channelVC.register(userMessageCell: CustomUserMessageCell())
            
            // Move to ChannelViewController using customized components
            self.navigationController?.pushViewController(channelVC, animated: true)
        }
    }
    
    static func functionOverridingCustom() {
        // TODO:
    }
}


extension ChannelCustomManager {
    @objc static func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
