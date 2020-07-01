//
//  CustomFontSet.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/01.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class CustomFontSet: NSObject {
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
}
