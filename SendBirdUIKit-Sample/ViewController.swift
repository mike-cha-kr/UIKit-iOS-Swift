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
    case startChat
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
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var lightThemeLabel: UILabel!
    @IBOutlet weak var darkThemeLabel: UILabel!
    @IBOutlet weak var startChatButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var customSamplesButton: UIButton!
    
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
        }
    }
    
    var isLightTheme = true {
        didSet {
            let black = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.88)
            let blackGray = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38)
            let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.88)
            let whiteGray = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.38)
             
            setNeedsStatusBarAppearanceUpdate()
            titleLabel.changeColor(isLightTheme ? black : white, duration: duration)
            lightThemeLabel.changeColor(isLightTheme ? black : whiteGray, duration: duration)
            darkThemeLabel.changeColor(!isLightTheme ? white : blackGray, duration: duration)

            let color = isLightTheme ? UIColor.white : UIColor.black
            UIView.animate(withDuration: duration, animations: {
                self.view.backgroundColor = color
            })
            [userIdTextField ,nicknameTextField].forEach {
                $0?.backgroundColor = isLightTheme ? #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) : #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2235294118, alpha: 1)
                $0?.textColor = isLightTheme ? #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.88) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.88)
            }
            UIView.transition(with: startChatButton, duration: duration, options: .transitionCrossDissolve, animations: {
                self.signInButton.setTitleColor(color, for: .normal)
                self.startChatButton.setTitleColor(color, for: .normal)
            })
            UIView.transition(with: customSamplesButton, duration: duration, options: .transitionCrossDissolve, animations: {
                self.customSamplesButton.setTitleColor(color, for: .normal)
            })
        }
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 12.0, *) {
            isLightTheme = traitCollection.userInterfaceStyle == .light
        }
        
        signInButton.tag    = ButtonType.signIn.rawValue
        startChatButton.tag = ButtonType.startChat.rawValue
        signOutButton.tag   = ButtonType.signOut.rawValue
        customSamplesButton.tag = ButtonType.customSamples.rawValue
        
        [signInButton, startChatButton, signOutButton, customSamplesButton].forEach {
            $0?.layer.cornerRadius = 4
            $0?.layer.borderColor = #colorLiteral(red: 0.4823529412, green: 0.3254901961, blue: 0.937254902, alpha: 1)
            $0?.layer.borderWidth = 1
        }
        
        signOutStackView.alpha = 0
         
        [userIdTextField, nicknameTextField].forEach {
            guard let textField = $0 else { return }
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.size.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            textField.tintColor = #colorLiteral(red: 0.4666666667, green: 0.337254902, blue: 0.8549019608, alpha: 1)
        }
 
        themeSwitch.tintColor = themeSwitch.onTintColor
        themeSwitch.layer.cornerRadius = themeSwitch.frame.height / 2
        themeSwitch.backgroundColor = themeSwitch.onTintColor
        
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
        if #available(iOS 13.0, *) {
            return isLightTheme ? .darkContent : .lightContent
        } else {
            return isLightTheme ? .default : .lightContent
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 12.0, *) {
            isLightTheme = traitCollection.userInterfaceStyle == .light
        }
    }
    
    
    // MARK: - Actions
    @IBAction func onEditingChangeTextField(_ sender: UITextField) {
        let color = sender.text?.isEmpty ?? true ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.4823529412, green: 0.3254901961, blue: 0.937254902, alpha: 1)
        sender.animateBorderColor(toColor: color, duration: 0.1)
    }
  
    @IBAction func onChangeSwitch(_ sender: Any) {
        isLightTheme = !self.themeSwitch.isOn
        
        UserDefaults.saveIsLightTheme(isLightTheme)
    }

    @IBAction func onTapButton(_ sender: UIButton) {
        let type = ButtonType(rawValue: sender.tag)
        switch type {
            
        case .signIn:
            self.signinAction()
            
        case .startChat:
            self.startChatAction()
            
        case .signOut:
            self.signoutAction()
            
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
                self?.themeSwitch.isOn = !(self?.isLightTheme ?? true)
            }
        }
    }
    
    func signoutAction() {
        SBUMain.unregisterPushToken { success in
            SBUMain.disconnect { [weak self] in
                print("SBUMain.disconnect")
                self?.isSignedIn = false
            }
        }
    }
    
    func startChatAction() {
        SBUTheme.set(theme: themeSwitch.isOn ? .dark : .light)
        let mainVC = SBUChannelListViewController()
        let naviVC = UINavigationController(rootViewController: mainVC)
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true)
    }
    
    func moveToCustomSamples() {
        SBUTheme.set(theme: themeSwitch.isOn ? .dark : .light)
        let mainVC = CustomListTableViewController(style: .grouped)
        let naviVC = UINavigationController(rootViewController: mainVC)
        naviVC.modalPresentationStyle = .fullScreen
        present(naviVC, animated: true)
    }
    
    
}
