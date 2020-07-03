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
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .messageListQuery:
            messageListQueryCustom()
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
        self.getSampleChannel { channel in
            guard let channel = channel else {
                SampleManager.showAlert(title: "No channel",
                                        message: "Create a channel and proceed.")
                return
            }
            
            let channelVC = SBUChannelViewController(channel: channel)
            
                    self.navigationController?.pushViewController(channelVC, animated: true)
        }

        // 이것은 NavigationBarButton을 변경
//        let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onClickBack))
//        channelList.leftBarButton = leftBarButton
//

    }
    
    static func messageListQueryCustom() {
        
    }
    
    static func messageParamsCustom() {
        
    }
    
    static func functionOverridingCustom() {
        
    }
}


extension ChannelCustomManager {
    static func getSampleChannel(completionHandler: @escaping (_ channel: SBDGroupChannel?) -> Void) {
        let channelListQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        channelListQuery?.order = .latestLastMessage
        channelListQuery?.limit = 10
        channelListQuery?.includeEmptyChannel = true
        
        channelListQuery?.loadNextPage(completionHandler: { channels, error in
            guard let channel = channels?.first else {
                completionHandler(nil)
                return
            }
            
            completionHandler(channel)
        })
    }
}
