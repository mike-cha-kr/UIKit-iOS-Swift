//
//  CustomListTableViewController.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/01.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

enum CustomSection: Int, CaseIterable {
    case Global = 0
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
        case .Global:
            return ["Color set", "Image set", "String set", "Theme"]
        case .ChannelList:
            return ["Channel list UI", "Channel query"]
        case .Channel:
            return ["Message list query", "Message params", "Message UI"]
        case .ChannelSettings:
            return ["Channel settings UI"]
        case .CreateChannel:
            return ["User list", "User type"]
        case .InviteUser:
            return ["User list", "User type"]
        case .MemberList:
            return ["User type"]
        case .none:
            return []
        }
    }
}

class CustomListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom Samples"
        
        self.createBackButton()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return CustomSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return CustomSection(rawValue: section)?.title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomSection.customItems(section: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let title: String = CustomSection.customItems(section: indexPath.section)[indexPath.row]
        cell.textLabel?.text = title

        return cell
    }
}


// MARK: - Navigation
extension CustomListTableViewController {
    func createBackButton() {
        let backButton = UIBarButtonItem( image: nil,
                                          style: .plain,
                                          target: self,
                                          action: #selector(onClickBack) )
        backButton.image = SBUIconSet.iconBack
        backButton.tintColor = SBUColorSet.primary300
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func onClickBack() {
        if let navigationController = self.navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
