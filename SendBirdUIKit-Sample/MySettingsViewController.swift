//
//  MySettingsViewController.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/09/11.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit
import Photos
import MobileCoreServices


class MySettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupStyles()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    public func setupStyles() {
        self.navigationController?.navigationBar.setBackgroundImage(
            UIImage.from(color: SBUColorSet.background100),
            for: .default
        )
        self.navigationController?.navigationBar.shadowImage = UIImage.from(
            color: SBUColorSet.onlight04
        )
        
//        self.leftBarButton?.tintColor = theme.leftBarButtonTintColor
//        self.rightBarButton?.tintColor = theme.rightBarButtonTintColor
        
        self.view.backgroundColor = .white
    }
}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage()}
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
