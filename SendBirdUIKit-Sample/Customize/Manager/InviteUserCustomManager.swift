//
//  InviteUserCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/02.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class InviteUserCustomManager: NSObject {
    static var navigationController: UINavigationController? = nil
    
    static func startSample(naviVC: UINavigationController, type: InviteUserCustomType?) {
        self.navigationController = naviVC
        
        switch type {
        case .uiComponent:
            uiComponentCustom()
        case .userList:
            userListCustom()
        case .userType:
            userTypeCustom()
        case .functionOverriding:
            functionOverridingCustom()
        default:
            break
        }
    }
}


extension InviteUserCustomManager {
    static func uiComponentCustom() {
        
        // 이것은 NavigationBarButton을 변경
//        let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onClickBack))
//        channelList.leftBarButton = leftBarButton
//
//        self.navigationController?.pushViewController(channelList, animated: true)
    }
    
    static func userListCustom() {
        
    }
    
    static func userTypeCustom() {
        
    }
    
    static func functionOverridingCustom() {
        
    }
}
