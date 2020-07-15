//
//  CustomUserMessageCell.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/07.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit
import SendBirdSDK

class CustomUserMessageCell: SBUUserMessageCell {
    override func setBackgroundColor(color: UIColor) {
        if self.message.customType == "highlight" {
            super.setBackgroundColor(color: UIColor(hex: "#F78900"))
        }
        else {
            super.setBackgroundColor(color: color)
        }
    }
}
