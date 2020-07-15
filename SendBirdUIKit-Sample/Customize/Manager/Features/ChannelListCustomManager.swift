//
//  ChannelListCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class ChannelListCustomManager: BaseCustomManager {
    static var shared = ChannelListCustomManager()
    
    func startSample(naviVC: UINavigationController, type: ChannelListCustomType?) {
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .customCell:
            cellCustom()
        case .listQuery:
            listQueryCustom()
        case .functionOverriding:
            functionOverridingCustom()
        default:
            break
        }
    }
}


extension ChannelListCustomManager {
    func uiComponentCustom() {
        let channelListVC = SBUChannelListViewController()
        
        // This part changes the default titleView to a custom view.
        channelListVC.titleView = self.createHighlightedTitleLabel()
        
        // This part changes the default leftBarButton to a custom leftBarButton. RightButton can also be changed in this way.
        channelListVC.leftBarButton = self.createHighlightedBackButton()
        
        // This part changes the default emptyView to a custom emptyView.
        let emptyView = CustomEmptyView()
        HighlightManager.highlight(emptyView)
        channelListVC.emptyView = emptyView
        
        // Move to ChannelListViewController using customized components
        self.navigationController?.pushViewController(channelListVC, animated: true)
    }
    
    func cellCustom() {
        let channelListVC = SBUChannelListViewController()
        
        // This part changes the default channel cell to a custom cell.
        channelListVC.register(channelCell: CustomChannelListCell())
        
        self.navigationController?.pushViewController(channelListVC, animated: true)
    }
    
    func listQueryCustom() {
        // You can customize the channel list using your own GroupChannelListQuery.
        // For all query options, refer to the `SBDGroupChannelListQuery` class.
        let listQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        listQuery?.includeEmptyChannel = true
        listQuery?.includeFrozenChannel = true
        // ... You can set more query options
        
        // This part initialize the channel list with your own GroupChannelListQuery.
        let channelListVC = SBUChannelListViewController(channelListQuery: listQuery)
        
        // Move to the ChannelListViewController created using GroupChannelListQuery.
        self.navigationController?.pushViewController(channelListVC, animated: true)
    }
    
    func functionOverridingCustom() {
        // If you inherit `SBUChannelListViewController`, you can customize it by overriding some functions.
        let channelListVC = ChannelListVC_Overriding()
        self.navigationController?.pushViewController(channelListVC, animated: true)
    }
}
