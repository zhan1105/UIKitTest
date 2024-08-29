//
//  FaceRecognitionUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class FaceRecognitionUI: UIView {
    
    var backButtonAction: (() -> Void)?
    var verifyButtonAction: (() -> Void)?
    
    var message: String?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar()
        myTitleBar.titleLabel.text = "FaceID練習"
        myTitleBar.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let messageLabel = MyLabel().newLabel
        messageLabel.text = message ?? "FaceID"
        
        let verifyButton = MyButton().newButton
        verifyButton.setTitle("驗證", for: .normal)
        verifyButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        
        let spacer = mySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [messageLabel, verifyButton, spacer]).newStack
        subScreen.spacing = 15
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, subScreen]).newStack
        
        addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            myTitleBar.leadingAnchor.constraint(equalTo: appScreen.leadingAnchor),
            myTitleBar.trailingAnchor.constraint(equalTo: appScreen.trailingAnchor),
            
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
            subScreen.leadingAnchor.constraint(equalTo: appScreen.leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: appScreen.trailingAnchor),
            
            messageLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            messageLabel.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor),
            
            verifyButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            verifyButton.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor),
            verifyButton.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor),
            
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.8),
            spacer.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor),
            spacer.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor),
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonAction?()
    }
    
    @objc private func verifyButtonTapped() {
        verifyButtonAction?()
    }
}
