//
//  TextSettingUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/26.
//

import UIKit

class TextSettingUI: UIView {
    
    var firstTextField = UITextField()
    var checkButton = UIButton(type: .system)
    var spacer = UIView()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        firstTextField.borderStyle = .none
        firstTextField.placeholder = "請輸入1~2位大寫英文+8~9位數字"
        firstTextField.textColor = .black
        firstTextField.font = UIFont.title3
        firstTextField.backgroundColor = .white
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        
        checkButton.setTitle("檢查格式", for: .normal)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.title2.pointSize, weight: .bold)
        checkButton.tintColor = .white
        checkButton.backgroundColor = .blue
        checkButton.layer.cornerRadius = 10
        checkButton.translatesAutoresizingMaskIntoConstraints = false
                
        spacer.backgroundColor = .clear
        spacer.translatesAutoresizingMaskIntoConstraints = false
        
        let subScreen = UIStackView(arrangedSubviews: [firstTextField, checkButton, spacer])
        subScreen.axis = .vertical
        subScreen.distribution = .fill
        subScreen.spacing = 15
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            checkButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.8),
            
            firstTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            firstTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            checkButton.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            checkButton.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
        ])
    }
}
