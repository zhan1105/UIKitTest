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
        
        verifyButton.setTitle("驗證", for: .normal)
        
        let spacer = mySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [messageLabel, verifyButton, spacer])
        subScreen.spacing = 15
        
        addSubview(subScreen)
        
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),

            messageLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            verifyButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.8),
        ])
    }
}
