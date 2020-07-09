//
//  CustomNewMessageInfo.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/09.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class CustomNewMessageInfo: SBUNewMessageInfo {
    open override func setupViews() {
        super.setupViews()
        
        self.layer.shadowColor = SBUColorSet.secondary300.withAlphaComponent(0.2).cgColor
        self.messageInfoButton?.setTitle("You have new messages", for: .normal)
    }
    
    /// This function handles the initialization of styles.
    open override func setupStyles() {
//        self.messageInfoButton?.setImage(SBUIconSet.iconChevronDown.with(tintColor: SBUColorSet.secondary300), for: .normal)
        self.messageInfoButton?.setTitleColor(SBUColorSet.secondary500, for: .normal)
//        self.messageInfoButton?.setBackgroundImage(UIImage.from(color: theme.newMessageBackground), for: .normal)
//        self.messageInfoButton?.setBackgroundImage(UIImage.from(color: theme.newMessageHighlighted), for: .highlighted)
    }
    
    // MARK: - Common
    @objc override func onClickNewMessageInfo() {
        // If you want to customize newMemberInfo button click user button action, you can override and customize it here.
        AlertManager.showCustomInfo(#function)
        
        super.onClickNewMessageInfo()
    }
}
