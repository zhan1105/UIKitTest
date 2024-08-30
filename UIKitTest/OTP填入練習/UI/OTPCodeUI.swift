//
//  OTPCodeUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class OTPCodeUI: UIView {

    var otpTextField = MyTextField()
    weak var textFieldDelegate: UITextFieldDelegate?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        otpTextField.placeholder = "請輸入驗證碼"
        otpTextField.borderStyle = .line
        otpTextField.textContentType = .oneTimeCode
        otpTextField.delegate = textFieldDelegate
        otpTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [otpTextField, spacer])
        subScreen.alignment = .center
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            otpTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.9),
            
            otpTextField.topAnchor.constraint(equalTo: subScreen.topAnchor, constant: 15),
            otpTextField.bottomAnchor.constraint(equalTo: spacer.topAnchor, constant: -15),
            otpTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            otpTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15)
        ])
    }
}
