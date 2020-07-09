//
//  GlobalSetCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class GlobalSetCustomManager: NSObject {
    static func startSample(naviVC: UINavigationController, type: GlobalCustomType?) {
        setDefault()
        
        var isThemeChanged = false
        
        switch type {
        case .colorSet:
            setCustomGlobalColorSet()
        case .fontSet:
            setCustomGlobalFontSet()
        case .iconSet:
            setCustomGlobalIconSet()
        case .stringSet:
            setCustomGlobalStringSet()
        case .theme:
            setCustomGlobalTheme()
            isThemeChanged = true
        default:
            break
        }

        // globalset 에 설정된 값들은, 최종적으로 theme 을 설정할때 사용되어 반영된다. theme를 변경한 경우에는 이미 변경과정에서 set 을 했기 때문에 light, dark 타입으로 셋하지 않아야 한다.
        if !isThemeChanged {
            SBUTheme.set(theme: UserDefaults.loadIsLightTheme() ? .light : .dark)
        }
        let channelListVC = SBUChannelListViewController()
        naviVC.pushViewController(channelListVC, animated: true)
    }
    
    static func setDefault() {
        setDefaultGlobalColorSet()
        setDefaultGlobalFontSet()
        setDefaultGlobalIconSet()
        setDefaultGlobalStringSet()
        setDefaultGlobalTheme()
    }
}


// MARK: - GlobalSet to custom
extension GlobalSetCustomManager {
    /// This is an example of customizing the global color set. You can change the required values ​​one by one.
    static func setCustomGlobalColorSet() {
        let customColor = UIColor.red
        SBUColorSet.primary100 = customColor.withAlphaComponent(20)
        SBUColorSet.primary200 = customColor.withAlphaComponent(40)
        SBUColorSet.primary300 = customColor.withAlphaComponent(60)
        SBUColorSet.primary400 = customColor.withAlphaComponent(80)
        SBUColorSet.primary500 = customColor
    }

    /// This is an example of customizing the global font set. You can change the required values ​​one by one.
    static func setCustomGlobalFontSet() {
        SBUFontSet.h1 = UIFont.init(name: "Copperplate-Light", size: 20.0) ?? UIFont()
        SBUFontSet.h2 = UIFont.init(name: "Copperplate-Bold", size: 18.0) ?? UIFont()
        SBUFontSet.body1 = UIFont.init(name: "Copperplate-Light", size: 16.0) ?? UIFont()
        SBUFontSet.body2 = UIFont.init(name: "Copperplate-Light", size: 16.0) ?? UIFont()
        SBUFontSet.button1 = UIFont.init(name: "Copperplate", size: 22.0) ?? UIFont()
        SBUFontSet.button2 = UIFont.init(name: "Copperplate-Light", size: 18.0) ?? UIFont()
        SBUFontSet.button3 = UIFont.init(name: "Copperplate-Light", size: 16.0) ?? UIFont()
        SBUFontSet.caption1 = UIFont.init(name: "Copperplate", size: 14.0) ?? UIFont()
        SBUFontSet.caption2 = UIFont.init(name: "Copperplate-Light", size: 14.0) ?? UIFont()
        SBUFontSet.caption3 = UIFont.init(name: "Copperplate-Light", size: 13.0) ?? UIFont()
        SBUFontSet.subtitle1 = UIFont.init(name: "Copperplate-Light", size: 18.0) ?? UIFont()
        SBUFontSet.subtitle2 = UIFont.init(name: "Copperplate-Light", size: 18.0) ?? UIFont()
    }
    
    /// This is an example of customizing the global icon set. You can change the required values ​​one by one.
    static func setCustomGlobalIconSet() {
        SBUIconSet.iconCreate = UIImage(named: "iconCreateCustom")!
    }
    
    /// This is an example of customizing the global string set. You can change the required values ​​one by one.
    static func setCustomGlobalStringSet() {
        SBUStringSet.ChannelList_Header_Title = "Chat list"
        SBUStringSet.ChannelSettings_Header_Title = "Settings"
        SBUStringSet.CreateChannel_Header_Title = "Create Chat"
    }
    
    /// This is an example of customizing the global theme.
    static func setCustomGlobalTheme() {
        let channelListTheme = SBUChannelListTheme()
        channelListTheme.leftBarButtonTintColor = SBUColorSet.secondary300
        channelListTheme.rightBarButtonTintColor = SBUColorSet.secondary300
        channelListTheme.notificationOnBackgroundColor = SBUColorSet.secondary300
        // ... In this way, you can add theme attributes.
        
        let channelCellTheme = SBUChannelCellTheme()
        channelCellTheme.unreadCountBackgroundColor = SBUColorSet.secondary300
        
        let channelTheme = SBUChannelTheme()
        channelTheme.leftBarButtonTintColor = SBUColorSet.secondary300
        channelTheme.rightBarButtonTintColor = SBUColorSet.secondary300
        channelTheme.cancelItemColor = SBUColorSet.secondary300
        channelTheme.alertCancelColor = SBUColorSet.secondary300
        
        let messageInputTheme = SBUMessageInputTheme()
        messageInputTheme.textFieldTintColor = SBUColorSet.secondary300
        messageInputTheme.buttonTintColor = SBUColorSet.secondary300
        
        let messageCellTheme = SBUMessageCellTheme()
        messageCellTheme.leftPressedBackgroundColor = SBUColorSet.secondary100
        messageCellTheme.rightBackgroundColor = SBUColorSet.secondary300
        messageCellTheme.rightPressedBackgroundColor = SBUColorSet.secondary400
        messageCellTheme.pendingStateColor = SBUColorSet.secondary300
        messageCellTheme.readReceiptStateColor = SBUColorSet.primary300
        messageCellTheme.fileIconColor = SBUColorSet.secondary300
        
        let customTheme = SBUTheme(channelListTheme: channelListTheme,
                                   channelCellTheme: channelCellTheme,
                                   channelTheme: channelTheme,
                                   messageInputTheme: messageInputTheme,
                                   messageCellTheme: messageCellTheme)
        SBUTheme.set(theme: customTheme)
    }
}


// MARK: - GlobalSet to Default
extension GlobalSetCustomManager {
    /// This is an function of changing the global primary colors to default.
    static func setDefaultGlobalColorSet() {
        SBUColorSet.primary100 = UIColor(red: 226.0 / 255.0, green: 223.0 / 255.0, blue: 1.0, alpha: 1.0)
        SBUColorSet.primary200 = UIColor(red: 158.0 / 255.0, green: 140.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        SBUColorSet.primary300 = UIColor(red: 123.0 / 255.0, green: 83.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
        SBUColorSet.primary400 = UIColor(red: 100.0 / 255.0, green: 64.0 / 255.0, blue: 196.0 / 255.0, alpha: 1.0)
        SBUColorSet.primary500 = UIColor(red: 77.0 / 255.0, green: 42.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
    }
    
    /// This is an function of changing the global font set to default.
    static func setDefaultGlobalFontSet() {
        SBUFontSet.h1 = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        SBUFontSet.h2 = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        SBUFontSet.body1 = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        SBUFontSet.body2 = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        SBUFontSet.button1 = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        SBUFontSet.button2 = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        SBUFontSet.button3 = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        SBUFontSet.caption1 = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        SBUFontSet.caption2 = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        SBUFontSet.caption3 = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        SBUFontSet.subtitle1 = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        SBUFontSet.subtitle2 = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }
    
    /// This is an function of changing the global icon set to default.
    static func setDefaultGlobalIconSet() {
        SBUIconSet.iconCreate = UIImage(named: "iconCreate")!
    }
    
    /// This is an function of changing the global string set to default.
    static func setDefaultGlobalStringSet() {
        SBUStringSet.ChannelList_Header_Title = "Channels"
        SBUStringSet.ChannelSettings_Header_Title = "Channel information"
        SBUStringSet.CreateChannel_Header_Title = "New Channel"
    }
    
    /// This is an function of changing the global theme to default.
    static func setDefaultGlobalTheme() {
        SBUTheme.set(theme: UserDefaults.loadIsLightTheme() ? .light : .dark)
    }
}
