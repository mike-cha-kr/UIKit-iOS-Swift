//
//  AlertManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/03.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdSDK
import SendBirdUIKit

class AlertManager: NSObject {
    static func show(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showCustomInfo(message: String) {
        self.show(title: "Custom", message: message)
    }
}

class ChannelManager: NSObject {
    static func getSampleChannel(completionHandler: @escaping (_ channel: SBDGroupChannel) -> Void) {
        let channelListQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        channelListQuery?.order = .latestLastMessage
        channelListQuery?.limit = 10
        channelListQuery?.includeEmptyChannel = true
        
        channelListQuery?.loadNextPage(completionHandler: { channels, error in
            guard let channel = channels?.first else {
                AlertManager.show(title: "No channel", message: "Create a channel and proceed.")
                return
            }
            
            completionHandler(channel)
        })
    }
}

class HighlightManager: NSObject {
    static func highlight(_ view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        for v in view.subviews { highlight(v) }
    }
}
