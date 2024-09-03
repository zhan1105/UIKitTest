//
//  APITestUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/3.
//

import UIKit

class APITestUI: UIView {

    var checkButton = MyButton(text: "登入")
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        let arcNoTextField = MyTextField()
        arcNoTextField.text = "NA80012021"
        
        let passwordTextField = MyTextField()
        passwordTextField.text = "12345678"
        
        let noTextField = MyTextField()
        noTextField.text = "caaBb7r8S8OITb7N-17lDi:APA91bH7CDlPbeOXHUXfW9WStMdq2Ok70OqBNZwmw7PcJXpxBIo0pRVAa4TBiehQl9rDMX2rRLTdAyhKjws-jad6T_QQk-3jK7Lh2k10w3-XnN8CzlO0G3SrSAltcP31ZNda3KSNeA9Z"
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [arcNoTextField, passwordTextField, noTextField, checkButton, spacer])
        subScreen.spacing = 10
        subScreen.alignment = .center
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            arcNoTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            arcNoTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            arcNoTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            passwordTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            passwordTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            noTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            noTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            noTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            checkButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            checkButton.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            checkButton.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.6),
        ])
    }
}
