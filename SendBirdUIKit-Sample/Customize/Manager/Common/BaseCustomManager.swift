//
//  BaseCustomManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/09.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class BaseCustomManager: NSObject {
    var navigationController: UINavigationController? = nil
}

// Create views
extension BaseCustomManager {
    func createHighlightedBackButton() -> UIBarButtonItem {
        let backButton = UIButton(type: .custom)
        backButton.frame = .init(x: 0, y: 0, width: 50, height: 45)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(SBUColorSet.primary300, for: .normal)
        backButton.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
        HighlightManager.highlight(backButton)
        let backBarButton = UIBarButtonItem(customView: backButton)
        return backBarButton
    }
    
    func createHighlightedTitleLabel() -> UILabel {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.view.bounds.width ?? 375, height: 50))
        titleLabel.text = "Custom Title"
        titleLabel.textColor = SBUColorSet.primary500
        HighlightManager.highlight(titleLabel)
        return titleLabel
    }
}


// Action
extension BaseCustomManager {
    @objc func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
