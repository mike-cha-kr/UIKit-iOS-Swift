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

enum MySettingsCellType: Int {
    case darkTheme, doNotDisturb, signOut
}

class MySettingsViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Property
    lazy var rightBarButton: UIBarButtonItem = {
        let rightItem =  UIBarButtonItem(
            title: SBUStringSet.Edit,
            style: .plain,
            target: self,
            action: #selector(onClickEdit)
        )
        rightItem.setTitleTextAttributes([.font : SBUFontSet.button2], for: .normal)
        return rightItem
    }()
    
    lazy var userInfoView = UserInfoTitleView()
    lazy var tableView = UITableView()
    
    var theme: SBUChannelSettingsTheme = SBUTheme.channelSettingsTheme
    
    // MARK: - Constant
    private let actionSheetIdEdit = 1
    private let actionSheetIdPicker = 2
    
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        
        // navigation bar
        self.navigationItem.rightBarButtonItem = self.rightBarButton
        
        // tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.bounces = false
        self.tableView.alwaysBounceVertical = false
        self.tableView.separatorStyle = .none
        self.tableView.register(
            type(of: MySettingsCell()),
            forCellReuseIdentifier: MySettingsCell.sbu_className
        )
        self.tableView.tableHeaderView = self.userInfoView
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.view.addSubview(self.tableView)
        
        // autolayout
        self.setupAutolayout()
        
        // styles
        self.setupStyles()
    }
    
    /// This function handles the initialization of autolayouts.
    open func setupAutolayout() {
        self.userInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        var layoutConstraints: [NSLayoutConstraint] = []
        
        layoutConstraints.append(self.userInfoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        layoutConstraints.append(self.userInfoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        layoutConstraints.append(self.userInfoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        layoutConstraints.append(self.userInfoView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor, constant: 0))

        layoutConstraints.append(self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))
        layoutConstraints.append(self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))
        layoutConstraints.append(self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0))
        layoutConstraints.append(self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0))
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    /// This function handles the initialization of styles.
    open func setupStyles() {
        self.navigationController?.navigationBar.setBackgroundImage(
            UIImage.from(color: SBUColorSet.background100),
            for: .default
        )
        self.navigationController?.navigationBar.shadowImage = UIImage.from(
            color: SBUColorSet.onlight04
        )
        
        self.rightBarButton.tintColor = SBUColorSet.primary300
        
        self.view.backgroundColor = SBUColorSet.background100 // 600
        self.tableView.backgroundColor = SBUColorSet.background100 // 600
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupStyles()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = SBUGlobals.CurrentUser {
            self.userInfoView.configure(user: user)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    
    // MARK: - Actions
    /// Open the user edit action sheet.
    @objc func onClickEdit() {
        let changeNameItem = SBUActionSheetItem(
            title: SBUStringSet.ChannelSettings_Change_Name,
            color: SBUColorSet.onlight01,
            image: nil
        )
        let changeImageItem = SBUActionSheetItem(
            title: SBUStringSet.ChannelSettings_Change_Image,
            color: SBUColorSet.onlight01,
            image: nil
        )
        let cancelItem = SBUActionSheetItem(
            title: SBUStringSet.Cancel,
            color: SBUColorSet.primary300 // 200
        )
        SBUActionSheet.show(
            items: [changeNameItem, changeImageItem],
            cancelItem: cancelItem,
            identifier: actionSheetIdEdit,
            delegate: self
        )
    }
    
    /// Open the nickname change popup.
    public func changeNickname() {
        let okButton = SBUAlertButtonItem(title: SBUStringSet.OK) {[weak self] newNickname in
            guard let nickname = newNickname as? String,
                nickname.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
                else { return }
            
            SBUMain.updateUserInfo(nickname: nickname, profileUrl: nil) { (error) in
                guard error == nil, let user = SBUGlobals.CurrentUser else { return }
                self?.userInfoView.configure(user: user)
            }
        }
        let cancelButton = SBUAlertButtonItem(title: SBUStringSet.Cancel) { _ in }
        SBUAlertView.show(
            title: SBUStringSet.ChannelSettings_Change_Name,
            needInputField: true,
            placeHolder: SBUStringSet.ChannelSettings_Enter_New_Name,
            centerYRatio: 0.75,
            confirmButtonItem: okButton,
            cancelButtonItem: cancelButton
        )
    }
    
    /// Open the user image selection menu.
    public func selectUserImage() {
        let cameraItem = SBUActionSheetItem(
            title: SBUStringSet.Camera,
            image: SBUIconSet.iconCamera.sbu_with(tintColor: SBUColorSet.primary300)
        )
        let libraryItem = SBUActionSheetItem(
            title: SBUStringSet.PhotoVideoLibrary,
            image: SBUIconSet.iconPhoto.sbu_with(tintColor: SBUColorSet.primary300)
        )
        let cancelItem = SBUActionSheetItem(
            title: SBUStringSet.Cancel,
            color: SBUColorSet.primary300
        )
        SBUActionSheet.show(
            items: [cameraItem, libraryItem],
            cancelItem: cancelItem,
            identifier: actionSheetIdPicker,
            delegate: self
        )
    }
}


// MARK: - UITableView relations
extension MySettingsViewController: UITableViewDataSource, UITableViewDelegate {
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let userInfoView = self.userInfoView as? UserInfoView {
//            userInfoView.endEditing(true)
//        }
//
//        let rowValue = indexPath.row + (self.isOperator ? 0 : 1)
//        let type = ChannelSettingItemType(rawValue: rowValue)
//        switch type {
//        case .moderations:
//            self.showModerationList()
//        case .notifications:
//            break
//        case .members:
//            self.showMemberList()
//        case .leave:
//            self.leaveChannel()
//        default:
//            break
//        }
    }

    open func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MySettingsCell.sbu_className
            ) as? MySettingsCell else { fatalError() }

        cell.selectionStyle = .none

        let rowValue = indexPath.row
        if let type = MySettingsCellType(rawValue: rowValue) {
            cell.configure(type: type)

//            if type == .notifications {
//                cell.switchAction = { [weak self] isOn in
//                    self?.changeNotification(isOn: isOn)
//                }
//            }
        }

        return cell
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}


// MARK: SBUActionSheetDelegate
extension MySettingsViewController: SBUActionSheetDelegate {
    public func didSelectActionSheetItem(index: Int, identifier: Int) {
        if identifier == actionSheetIdEdit {
            let type = ChannelEditType.init(rawValue: index)
            switch type {
            case .name:
                self.changeNickname()
            case .image:
                self.selectUserImage()
            default:
                break
            }
        }
        else {
            let type = MediaResourceType.init(rawValue: index)
            var sourceType: UIImagePickerController.SourceType = .photoLibrary
            let mediaType: [String] = [String(kUTTypeImage)]
            
            switch type {
            case .camera:
                sourceType = .camera
            case .library:
                sourceType = .photoLibrary
            case .document:
                break
            default:
                break
            }
            
            if type != .document {
                if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    let imagePickerController = UIImagePickerController()
                    imagePickerController.delegate = self
                    imagePickerController.sourceType = sourceType
                    imagePickerController.mediaTypes = mediaType
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            }
        }
    }
}


// MARK: UIImagePickerViewControllerDelegate
extension MySettingsViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) { [weak self] in
            guard let originalImage = info[.originalImage] as? UIImage else { return }
            
            self?.userInfoView.coverImage.image = originalImage
            
            SBUMain.updateUserInfo(nickname: nil, profileImage: originalImage.jpegData(compressionQuality: 0.5)) { error in
                guard error == nil, let user = SBUGlobals.CurrentUser else { return }
                self?.userInfoView.configure(user: user)
            }
        }
    }
}
