//
//  CustomSampleEnums.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/03.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit

// MARK: - Enums for Manager
enum GlobalCustomType: Int {
    case colorSet
    case fontSet
    case iconSet
    case stringSet
    case theme
}

enum ChannelListCustomType: Int {
    case uiComponent
    case listQuery
    case functionOverriding
}

enum ChannelSettingsCustomType: Int {
    case uiComponent
    case functionOverriding
}

enum CreateChannelCustomType: Int {
    case uiComponent
    case userList
    case userType
    case functionOverriding
}

enum InviteUserCustomType: Int {
    case uiComponent
    case userList
    case userType
    case functionOverriding
}

enum MemberListCustomType: Int {
    case uiComponent
    case userType
    case functionOverriding
}

enum ChannelCustomType: Int {
    case uiComponent
    case messageListQuery
    case messageParams
    case functionOverriding
}


// MARK: - Enum for CustomBaseViewController
enum CustomSection: Int, CaseIterable {
    case Default = 0
    case Global
    case ChannelList
    case Channel
    case ChannelSettings
    case CreateChannel
    case InviteUser
    case MemberList
    
    var title: String { return String(describing: self) }
    var index: Int { return self.rawValue }
    static func customItems(section: Int) -> [String] {
        let sectionIdx = CustomSection(rawValue: section)
        switch sectionIdx {
        case .Default:
            return ["Default"]
        case .Global:
            return ["Color set",
                    "Font set",
                    "Icon set",
                    "String set",
                    "Theme"]
        case .ChannelList:
            return ["UI Component",
                    "ChannelListQuery",
                    "Function Overriding"]
        case .Channel:
            return ["UI Component",
                    "MessageListQuery",
                    "MessageParams",
                    "Function Overriding"]
        case .ChannelSettings:
            return ["UI Component",
                    "Function Overriding"]
        case .CreateChannel:
            return ["UI Component",
                    "User list",
                    "User type",
                    "Function Overriding"]
        case .InviteUser:
            return ["UI Component",
                    "User list",
                    "User type",
                    "Function Overriding"]
        case .MemberList:
            return ["UI Component",
                    "User type",
                    "Function Overriding"]
        case .none:
            return []
        }
    }
    
    static func customItemDescriptions(section: Int) -> [String] {
        let sectionIdx = CustomSection(rawValue: section)
        switch sectionIdx {
        case .Default:
            return [""]
        case .Global:
            return ["[GlobalSetCustomManager setCustomGlobalColorSet()]",
                    "[GlobalSetCustomManager setCustomGlobalFontSet()]",
                    "[GlobalSetCustomManager setCustomGlobalIconSet()]",
                    "[GlobalSetCustomManager setCustomGlobalStringSet()]",
                    "[GlobalSetCustomManager setCustomGlobalTheme()]"]
        case .ChannelList:
            return ["[ChannelListCustomManager uiComponentCustom()]",
                    "[ChannelListCustomManager listQueryCustom()]",
                    "ChannelListCustomViewController.swift"]
        case .Channel:
            return ["[ChannelCustomManager uiComponentCustom()]",
                    "[ChannelCustomManager messageListQueryCustom()]",
                    "[ChannelCustomManager messageParamsCustom()]",
                    "ChannelCustomViewController.swift"]
        case .ChannelSettings:
            return ["[ChannelSettingsCustomManager uiComponentCustom()]",
                    "ChannelSettingsCustomViewController.swift"]
        case .CreateChannel:
            return ["[CreateChannelCustomManager uiComponentCustom()]",
                    "[CreateChannelCustomManager userListCustom()]",
                    "[CreateChannelCustomManager userTypeCustom()]",
                    "CreateChannelCustomViewController.swift"]
        case .InviteUser:
            return ["[InviteUserCustomManager uiComponentCustom()]",
                    "[InviteUserCustomManager userListCustom()]",
                    "[InviteUserCustomManager userTypeCustom()]",
                    "InviteUserCustomViewController.swift"]
        case .MemberList:
            return ["[MemberListCustomManager uiComponentCustom()]",
                    "[MemberListCustomManager userTypeCustom()]",
                    "MemberListCustomViewController.swift"]
        case .none:
            return []
        }
    }
}
