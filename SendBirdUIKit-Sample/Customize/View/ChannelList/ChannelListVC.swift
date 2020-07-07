//
//  ChannelListVC.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class ChannelListVC: SBUChannelListViewController {
    // MARK: - Show relations
    override func showChannel(channelUrl: String) {
        // If you want to use your own ChannelViewController, you can override and customize it here.
        AlertManager.showCustomInfo(message: "showChannel function can be customized.")
    }
    
    override func showCreateChannel() {
        // If you want to use your own CreateChannelViewController, you can override and customize it here.
        
        AlertManager.showCustomInfo(message: "showCreateChannel function can be customized.")
    }
    
    // MARK: SBDConnectionDelegate
    override func didSucceedReconnection() {
        // If you override and customize this function, you can handle it when reconnected.
        super.didSucceedReconnection()
    }
    
    
    // MARK: - Error handling
    override func didReceiveError(_ message: String?) {
        // If you override and customize this function, you can handle it when error received.
        print(message as Any);
    }
}
