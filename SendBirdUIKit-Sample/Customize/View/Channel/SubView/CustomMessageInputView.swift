//
//  CustomMessageInputView.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/03.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class CustomMessageInputView: SBUMessageInputView {
    
    override func onClickAddButton(_ sender: Any) {
        AlertManager.showCustomInfo(message: "onClickAddButton function can be customized.")
    }
    
    override func onClickSendButton(_ sender: Any) {
        AlertManager.showCustomInfo(message: "onClickSendButton function can be customized.")
    }
    
    override func onClickCancelButton(_ sender: Any) {
        AlertManager.showCustomInfo(message: "onClickCancelButton function can be customized.")
    }

    override func onClickSaveButton(_ sender: Any) {
        AlertManager.showCustomInfo(message: "onClickSaveButton function can be customized.")
    }
}
