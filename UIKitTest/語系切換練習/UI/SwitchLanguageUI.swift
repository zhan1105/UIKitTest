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
    
    var chineseButtonAction: (() -> Void)?
    var englishButtonAction: (() -> Void)?
    
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
        
        chineseButton = createToggleButton(title: "中文")
        englishButton = createToggleButton(title: "English")
    
        let buttonStack = UIStackView(arrangedSubviews: [chineseButton, englishButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 25
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = mySpacer()
        
        let subScreen = UIStackView(arrangedSubviews: [languageLabel, buttonStack, spacer])
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
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.8),
            
            languageLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            buttonStack.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
        let selectedLanguage: SwitchLanguage = (sender == chineseButton) ? .chinese : .english
        switch selectedLanguage {
        case .chinese:
            chineseButtonAction?()
        case .english:
            englishButtonAction?()
        }
    }
    
    private func createToggleButton(title: String) -> UIButton {
        let newButton = UIButton(type: .system)
        newButton.setTitle(title, for: .normal)
        newButton.titleLabel?.font = UIFont.boldTitle2
        newButton.tintColor = .white
        newButton.backgroundColor = UIColor.color0080FF
        newButton.layer.cornerRadius = 10
        newButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        return newButton
    }
}
