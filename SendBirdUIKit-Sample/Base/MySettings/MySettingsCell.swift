//
//  MySettingsCell.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/09/15.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdUIKit

class MySettingsCell: UITableViewCell {
    // MARK: - property
    lazy var baseStackView: UIStackView = {
        let baseStackView = UIStackView()
        baseStackView.spacing = 16.0
        baseStackView.axis = .horizontal
        return baseStackView
    }()
    
    var typeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var titleLabel = UILabel()
    
    lazy var rightSwitch: UISwitch = {
       let switchItem = UISwitch()
        switchItem.isHidden = true
        switchItem.addTarget(self, action: #selector(onChangeSwitch(_:)), for: .valueChanged)
        return switchItem
    }()
    
    var separateView = UIView()
    
    var theme: SBUChannelSettingsTheme = SBUTheme.channelSettingsTheme
    
    var switchAction: ((Bool) -> Void)? = nil
    
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupAutolayout()
        self.setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
        self.setupAutolayout()
        self.setupActions()
    }
    
    /// This function handles the initialization of views.
    func setupViews() {
        self.baseStackView.addArrangedSubview(self.typeIcon)
        self.baseStackView.addArrangedSubview(self.titleLabel)
        self.baseStackView.addArrangedSubview(self.rightSwitch)
        
        self.contentView.addSubview(self.baseStackView)
        self.contentView.addSubview(self.separateView)
    }
    
    /// This function handles the initialization of actions.
    func setupActions() {
        
    }
    
    /// This function handles the initialization of autolayouts.
    func setupAutolayout() {
        self.baseStackView.translatesAutoresizingMaskIntoConstraints = false
        self.typeIcon.translatesAutoresizingMaskIntoConstraints = false
        self.rightSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.separateView.translatesAutoresizingMaskIntoConstraints = false
        
        var layoutConstraints: [NSLayoutConstraint] = []
        
        layoutConstraints.append(self.baseStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16))
        layoutConstraints.append(self.baseStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16))
        layoutConstraints.append(self.baseStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 13))
        layoutConstraints.append(self.baseStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12))
        layoutConstraints.append(self.baseStackView.heightAnchor.constraint(equalToConstant: 31))
        
        layoutConstraints.append(self.typeIcon.widthAnchor.constraint(equalToConstant: 28))
        
        layoutConstraints.append(self.rightSwitch.widthAnchor.constraint(equalToConstant: 51))
        
        layoutConstraints.append(self.separateView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16))
        layoutConstraints.append(self.separateView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16))
        layoutConstraints.append(self.separateView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -0.5))
        layoutConstraints.append(self.separateView.heightAnchor.constraint(equalToConstant: 0.5))
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    /// This function handles the initialization of styles.
    func setupStyles() {
        self.theme = SBUTheme.channelSettingsTheme
        
        self.backgroundColor = theme.backgroundColor
        
        self.titleLabel.font = theme.cellTextFont
        self.titleLabel.textColor = theme.cellTextColor
        
        self.rightSwitch.onTintColor = theme.cellSwitchColor
        
        self.separateView.backgroundColor = theme.cellSeparateColor
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupStyles()
    }
    
    /// This function configure a cell using channel information.
    /// - Parameter channel: cell object
    open func configure(type: MySettingsCellType) {
        self.rightSwitch.isHidden = false
        
        switch type {
        case .darkTheme:
            self.typeIcon.image = UIImage(named: "iconTheme")?
                .sbu_with(tintColor: .white)
                .withBackground(
                    color: SBUColorSet.background400,
                    margin: 3,
                    circle: true
            )
            self.titleLabel.text = "Dark theme"
        case .doNotDisturb:
            self.typeIcon.image = UIImage(named: "iconNotificationsFilled")?
                .sbu_with(tintColor: .white)
                .withBackground(
                    color: SBUColorSet.secondary400,
                    margin: 3,
                    circle: true
            )
            self.titleLabel.text = "Do not disturb"
        case .signOut:
            self.typeIcon.image = UIImage(named: "iconLeave")?
                .sbu_with(tintColor: .white)
                .withBackground(
                    color: SBUColorSet.error,
                    margin: 3,
                    circle: true
            )
            self.titleLabel.text = "Sign out"
            self.rightSwitch.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func changeSwitch(_ isOn: Bool) {
        self.rightSwitch.isOn = isOn
    }

    
    // MARK: - Action
    @objc func onChangeSwitch(_ sender: Any) {
        self.switchAction?(rightSwitch.isOn)
    }
    
    func changeBackSwitch() {
        self.rightSwitch.isOn = !self.rightSwitch.isOn
    }
}
