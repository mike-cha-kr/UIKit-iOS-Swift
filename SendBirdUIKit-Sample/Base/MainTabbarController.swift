//
//  MainTabbarController.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/09/11.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

enum TabType {
    case channels, mySettings
}

class MainTabbarController: UITabBarController {
    let channelsViewController = ChannelListViewController()
    let settingsViewController = MySettingsViewController()
    
    var theme: SBUComponentTheme = SBUTheme.componentTheme

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelsViewController.leftBarButton = self.createLeftTitleItem(text: "Channels")
        channelsViewController.titleView = UIView()
        channelsViewController.tabBarItem = self.createTabItem(type: .channels)
        
        settingsViewController.navigationItem.leftBarButtonItem = self.createLeftTitleItem(text: "My settings")
        settingsViewController.tabBarItem = self.createTabItem(type: .mySettings)
        
        self.tabBar.tintColor = SBUColorSet.primary300
        
        let naviVC = UINavigationController(rootViewController: channelsViewController)
        let naviVC2 = UINavigationController(rootViewController: settingsViewController)
        
        let tabbarItems = [naviVC, naviVC2]
        self.viewControllers = tabbarItems
        
        SBDMain.add(self, identifier: self.sbu_className)
        
        SBDMain.getTotalUnreadMessageCount { (totalCount, error) in
            self.setUnreadMessagesCount(totalCount)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SBDMain.removeAllUserEventDelegates()
    }
    
    
    // MARK: - Create items
    func createLeftTitleItem(text: String) -> UIBarButtonItem {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        titleLabel.textColor = theme.titleColor
        return UIBarButtonItem.init(customView: titleLabel)
    }
    
    func createTabItem(type: TabType) -> UITabBarItem {
        let iconSize = CGSize(width: 24, height: 24)
        let title = type == .channels ? "Channels" : "My settings"
        let icon = type == .channels
            ? UIImage(named: "iconChatFilled")?.resize(with: iconSize)
            : UIImage(named: "iconSettingsFilled")?.resize(with: iconSize)
        let tag = type == .channels ? 0 : 1
        
        let item = UITabBarItem(title: title, image: icon, tag: tag)
        return item
    }
    
    
    // MARK: - Common
    func setUnreadMessagesCount(_ totalCount: UInt) {
        if totalCount == 0 {
            self.channelsViewController.tabBarItem.badgeValue = nil
        } else if totalCount > 99 {
            self.channelsViewController.tabBarItem.badgeValue = "99+"
        } else {
            self.channelsViewController.tabBarItem.badgeValue = "\(totalCount)"
        }
    }
}

extension MainTabbarController: SBDUserEventDelegate {
    func didUpdateTotalUnreadMessageCount(_ totalCount: Int32, totalCountByCustomType: [String : NSNumber]?) {
        self.setUnreadMessagesCount(UInt(totalCount))
    }
}
