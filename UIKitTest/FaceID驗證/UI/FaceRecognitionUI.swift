//
//  FaceRecognitionUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class FaceRecognitionUI: UIView {
    
    var messageLabel = MyLabel()
    var verifyButton = MyButton()
            
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        messageLabel.text = "FaceID"
        messageLabel.numberOfLines = 0
        
        verifyButton.setTitle("驗證", for: .normal)
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [messageLabel, verifyButton, spacer])
        subScreen.spacing = 15
        
        addSubview(subScreen)
        
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),

            messageLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            verifyButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.75),
            
            verifyButton.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            verifyButton.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
        ])
    }
}
