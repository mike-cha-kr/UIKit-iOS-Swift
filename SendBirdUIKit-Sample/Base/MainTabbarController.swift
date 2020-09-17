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
    var isDarkMode: Bool = false

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelsViewController.titleView = UIView()
        
        let naviVC = UINavigationController(rootViewController: channelsViewController)
        let naviVC2 = UINavigationController(rootViewController: settingsViewController)
        
        let tabbarItems = [naviVC, naviVC2]
        self.viewControllers = tabbarItems
        
        self.setupStyles()
        
        SBDMain.add(self, identifier: self.sbu_className)
        
        self.loadTotalUnreadMessageCount()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        SBDMain.removeAllUserEventDelegates()
    }
    
    public func setupStyles() {
        self.theme = SBUTheme.componentTheme
        
        self.tabBar.barTintColor = self.isDarkMode ? SBUColorSet.background600 : SBUColorSet.background100
        self.tabBar.tintColor = self.isDarkMode ? SBUColorSet.primary200 : SBUColorSet.primary300
        channelsViewController.navigationItem.leftBarButtonItem = self.createLeftTitleItem(text: "Channels")
        channelsViewController.tabBarItem = self.createTabItem(type: .channels)
        
        settingsViewController.navigationItem.leftBarButtonItem = self.createLeftTitleItem(text: "My settings")
        settingsViewController.tabBarItem = self.createTabItem(type: .mySettings)
    }
    
    
    // MARK: - SDK related
    func loadTotalUnreadMessageCount() {
        SBDMain.getTotalUnreadMessageCount { (totalCount, error) in
            self.setUnreadMessagesCount(totalCount)
        }
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
    
    func updateTheme(isDarkMode: Bool) {
        self.isDarkMode = isDarkMode
        
        self.setupStyles()
        self.channelsViewController.setupStyles()
        self.settingsViewController.setupStyles()

        self.channelsViewController.reloadTableView()
        
        self.loadTotalUnreadMessageCount()
    }
}

extension MainTabbarController: SBDUserEventDelegate {
    func didUpdateTotalUnreadMessageCount(_ totalCount: Int32, totalCountByCustomType: [String : NSNumber]?) {
        self.setUnreadMessagesCount(UInt(totalCount))
    }
}
