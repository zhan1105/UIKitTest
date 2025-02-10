//
//  SwitchLanguageUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/27.
//

import UIKit

class SwitchLanguageUI: UIView {
    
    var languageLabel = UILabel()
    var chineseButton = UIButton(type: .system)
    var englishButton = UIButton(type: .system)
    var vietnameseButton = UIButton(type: .system)
    var indonesianButton = UIButton(type: .system)
    
    var chineseButtonAction: (() -> Void)?
    var englishButtonAction: (() -> Void)?
    var vietnameseButtonAction: (() -> Void)?
    var indonesianButtonAction: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        languageLabel.text = NSLocalizedString("Hello", comment: "")
        languageLabel.font = UIFont.boldTitle1
        languageLabel.textColor = .black
        languageLabel.textAlignment = .center
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chineseButton = createToggleButton(title: NSLocalizedString("Chinese", comment: ""))
        englishButton = createToggleButton(title: NSLocalizedString("English", comment: ""))
        vietnameseButton = createToggleButton(title: NSLocalizedString("Vietnamese", comment: ""))
        indonesianButton = createToggleButton(title: NSLocalizedString("Indonesian", comment: ""))
        
        let buttonStack = createButtonStack(chineseButton, englishButton)
        let buttonStack2 = createButtonStack(vietnameseButton, indonesianButton)
        
        let spacer = MySpacer()
        
        let subScreen = UIStackView(arrangedSubviews: [languageLabel, buttonStack, buttonStack2, spacer])
        subScreen.axis = .vertical
        subScreen.distribution = .fill
        subScreen.spacing = 15
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            languageLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            buttonStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            buttonStack2.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.7),
            
            languageLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            buttonStack.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
            buttonStack2.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            buttonStack2.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
        let selectedLanguage: SwitchLanguage
        if sender == chineseButton {
            selectedLanguage = .chinese
        } else if sender == englishButton {
            selectedLanguage = .english
        } else if sender == vietnameseButton {
            selectedLanguage = .vietnamese
        } else if sender == indonesianButton {
            selectedLanguage = .indonesian
        } else {
            return
        }
        
        switch selectedLanguage {
        case .chinese:
            chineseButtonAction?()
        case .english:
            englishButtonAction?()
        case .vietnamese:
            vietnameseButtonAction?()
        case .indonesian:
            indonesianButtonAction?()
        }
    }
    
    private func createToggleButton(title: String) -> UIButton {
        let newButton = UIButton(type: .system)
        newButton.setTitle(title, for: .normal)
        newButton.titleLabel?.font = UIFont.boldTitle2
        newButton.tintColor = .white
        newButton.backgroundColor = UIColor.oceanBlue
        newButton.layer.cornerRadius = 10
        newButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        return newButton
    }
    
    private func createButtonStack(_ firstButton: UIButton, _ secondButton: UIButton) -> UIStackView {
        let newStack = UIStackView(arrangedSubviews: [firstButton, secondButton])
        newStack.axis = .horizontal
        newStack.distribution = .fillEqually
        newStack.spacing = 25
        newStack.translatesAutoresizingMaskIntoConstraints = false
        
        return newStack
    }
}
