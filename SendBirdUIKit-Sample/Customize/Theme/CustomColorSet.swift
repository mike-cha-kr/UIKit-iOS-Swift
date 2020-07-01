//
//  CustomColorSet.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/01.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class CustomColorSet: NSObject {
    /// This is an example of customizing the global primary colors. You can change the required values ​​one by one.
    static func setCustomGlobalColorSet() {
        let customColor = UIColor.red
        SBUColorSet.primary100 = customColor.withAlphaComponent(20)
        SBUColorSet.primary200 = customColor.withAlphaComponent(40)
        SBUColorSet.primary300 = customColor.withAlphaComponent(60)
        SBUColorSet.primary400 = customColor.withAlphaComponent(80)
        SBUColorSet.primary500 = customColor
    }
    
    /// This is an function of changing the global primary colors to default.
    static func setDefaultGlobalColorSet() {
        SBUColorSet.primary100 = UIColor(red: 226.0 / 255.0, green: 223.0 / 255.0, blue: 1.0, alpha: 1.0)
        SBUColorSet.primary200 = UIColor(red: 158.0 / 255.0, green: 140.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        SBUColorSet.primary300 = UIColor(red: 123.0 / 255.0, green: 83.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
        SBUColorSet.primary400 = UIColor(red: 100.0 / 255.0, green: 64.0 / 255.0, blue: 196.0 / 255.0, alpha: 1.0)
        SBUColorSet.primary500 = UIColor(red: 77.0 / 255.0, green: 42.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
    }
}
