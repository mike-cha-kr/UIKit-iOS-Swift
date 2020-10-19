//
//  ViewController.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 11/03/2020.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

enum ButtonType: Int {
    case signIn
    case startChatWithVC
    case startChatWithTC
    case signOut
    case customSamples
}

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var logoStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var signInStackView: UIStackView!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signOutStackView: UIStackView!
    @IBOutlet weak var startChatWithViewControllerButton: UIButton!
    @IBOutlet weak var startChatWithTabbarControllerButton: UIButton!
    @IBOutlet weak var customSamplesButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
            loadingIndicator.stopAnimating()
        }
    }

    let duration: TimeInterval = 0.4
    var isSignedIn = false {
        didSet {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.signInStackView.isHidden = self.isSignedIn
                self.signInStackView.alpha = self.isSignedIn ? 0 : 1
                self.signOutStackView.alpha = !self.isSignedIn ? 0 : 1
                self.signOutStackView.isHidden = !self.isSignedIn
            })
            self.view.endEditing(true)
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        SBUTheme.set(theme: .light)
        GlobalSetCustomManager.setDefault()
        
        nicknameTextField.text = UserDefaults.loadNickname()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.tag    = ButtonType.signIn.rawValue
        signOutButton.tag   = ButtonType.signOut.rawValue
        
        startChatWithViewControllerButton.tag = ButtonType.startChatWithVC.rawValue
        startChatWithTabbarControllerButton.tag = ButtonType.startChatWithTC.rawValue
        customSamplesButton.tag = ButtonType.customSamples.rawValue
        
        [startChatWithViewControllerButton,
         startChatWithTabbarControllerButton,
         customSamplesButton,
         signInButton,
         signOutButton].forEach {
            $0?.layer.cornerRadius = 4
        }
        
        [signOutButton].forEach {
            $0?.layer.borderColor = #colorLiteral(red: 0.4823529412, green: 0.3254901961, blue: 0.937254902, alpha: 1)
            $0?.layer.borderWidth = 1
        }
        
        signOutStackView.alpha = 0
         
        [userIdTextField, nicknameTextField].forEach {
            guard let textField = $0 else { return }
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: 16,
                height: textField.frame.size.height)
            )
            textField.leftView = paddingView
            textField.leftViewMode = .always
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            textField.tintColor = #colorLiteral(red: 0.4666666667, green: 0.337254902, blue: 0.8549019608, alpha: 1)
        }
 
        UserDefaults.saveIsLightTheme(true)
        
        let coreVersion: String = SBDMain.getSDKVersion()
        let uikitVersion: String = SBUMain.shortVersionString() ?? "?"
        versionLabel.text = "UIKit v\(uikitVersion)\t|\tSDK v\(coreVersion)"
         
        userIdTextField.text = UserDefaults.loadUserID()
        nicknameTextField.text = UserDefaults.loadNickname()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.logoStackView.isHidden = UIDevice.current.orientation.isLandscape
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    
    // MARK: - Actions
    @IBAction func onEditingChangeTextField(_ sender: UITextField) {
        let color = sender.text?.isEmpty ?? true ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.4823529412, green: 0.3254901961, blue: 0.937254902, alpha: 1)
        sender.animateBorderColor(toColor: color, duration: 0.1)
    }
  
    @IBAction func onTapButton(_ sender: UIButton) {
        let type = ButtonType(rawValue: sender.tag)

        switch type {
        case .signIn:
            self.signinAction()
        case .startChatWithVC, .startChatWithTC:
            self.startChatAction(type: type ?? .startChatWithVC)
        case .signOut:
            self.signOutAction()
        case .customSamples:
            self.moveToCustomSamples()
        default:
            break
        }
    }

    func signinAction() {
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        
        let userID = userIdTextField.text ?? ""
        let nickname = nicknameTextField.text ?? ""
        
        guard !userID.isEmpty else {
            userIdTextField.shake()
            userIdTextField.becomeFirstResponder()
            loadingIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
            return
        }
        guard !nickname.isEmpty else {
            nicknameTextField.shake()
            nicknameTextField.becomeFirstResponder()
            loadingIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
            return
        }
        
        SBUGlobals.CurrentUser = SBUUser(userId: userID, nickname: nickname)
        SBUMain.connect { [weak self] user, error in
            self?.loadingIndicator.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            
            if let user = user {
                UserDefaults.saveUserID(userID)
                UserDefaults.saveNickname(nickname)
                
                print("SBUMain.connect: \(user)")
                self?.isSignedIn = true
            }
        }
    }
    
    func signOutAction() {
        SBUMain.unregisterPushToken { success in
            SBUMain.disconnect { [weak self] in
                print("SBUMain.disconnect")
                self?.isSignedIn = false
            }
        }
    }
    
    func startChatAction(type: ButtonType) {
        if type == .startChatWithVC {
            let mainVC = SBUChannelListViewController()
            let naviVC = UINavigationController(rootViewController: mainVC)
            naviVC.modalPresentationStyle = .fullScreen
            present(naviVC, animated: true)
        }
        else if type == .startChatWithTC {
            let mainVC = MainTabbarController()
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true)
        }
    }
    
    func moveToCustomSamples() {
        SBUTheme.set(theme: .light)
        let mainVC = CustomBaseViewController(style: .grouped)
        let naviVC = UINavigationController(rootViewController: mainVC)
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true)
    }
    
    
}
