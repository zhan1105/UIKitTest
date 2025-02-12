//
//  MyTitleBar.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyTitleBar: UIView {
        
    private let titleLabel = MyLabel()
    private let backButton = UIButton(type: .system)
    private let optionsButton = MyPackageButton()
    
    var backButtonAction: (() -> Void)?

    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    var optionsButtonText: String? = nil {
        didSet {
            optionsButton.buttonText = optionsButtonText
        }
    }
    
    var isShowOptionsButton: Bool = false {
        didSet {
            optionsButton.buttonHidden = !isShowOptionsButton
        }
    }
    
    var optionsButtonAction: (() -> Void)? {
        didSet {
            optionsButton.buttonAction = optionsButtonAction
        }
    }
    
    // 初始化
    init(text: String = "標題") {
        super.init(frame: .zero)
        setupViews(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(text: String) {
        
        titleLabel.text = text
        titleLabel.font = .boldTitle2
        
        backButton.setImage(UIImage(systemSymbol: SFSymbol.arrow_left), for: .normal)
        backButton.tintColor = .black
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        isShowOptionsButton = false
        
        optionsButton.textFont = .boldSubheadline
        optionsButton.textColor = .oceanBlue
        optionsButton.buttonBackground = .softGray
        optionsButton.viewPadding(to: 12.5, top: 20, bottom: 20)
        
        
        let subScreen = MyStack(arrangedSubviews: [backButton, titleLabel, optionsButton])
        subScreen.axis = .horizontal
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.25),
            titleLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.5),
            optionsButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.25)
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonAction?()
    }
}

