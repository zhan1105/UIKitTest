//
//  TextSettingUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/26.
//

import UIKit

class TextSettingUI: UIView {
    
    var firstTextField = UITextField()
    var secondTextField = UITextField()
    var thirdTextField = UITextField()
    var checkButton = UIButton(type: .system)
    var spacer = UIView()
    
    var buttonAction: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        firstTextField = creatTextField(placeholder: "請輸入1~2位大寫英文+8~9位數字")
        secondTextField = creatTextField(placeholder: "請輸入大寫英文")
        thirdTextField = creatTextField(placeholder: "請輸入1位大寫英文+9位數字")
        
        checkButton.setTitle("檢查格式", for: .normal)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.title2.pointSize, weight: .bold)
        checkButton.tintColor = .white
        checkButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        checkButton.backgroundColor = .blue
        checkButton.layer.cornerRadius = 10
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        spacer.backgroundColor = .clear
        spacer.translatesAutoresizingMaskIntoConstraints = false
        
        let subScreen = UIStackView(arrangedSubviews: [firstTextField, secondTextField, thirdTextField, checkButton, spacer])
        subScreen.axis = .vertical
        subScreen.distribution = .fill
        subScreen.alignment = .center
        subScreen.spacing = 15
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            secondTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            thirdTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            checkButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.6),
            
            firstTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            firstTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            secondTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            secondTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            thirdTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            thirdTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10),
            
            checkButton.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 10),
            checkButton.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -10)
        ])
    }
    
    func creatTextField(placeholder: String) -> UITextField {
        
        let newTextField = UITextField()
        newTextField.borderStyle = .none
        newTextField.layer.cornerRadius = 10
        newTextField.placeholder = placeholder
        newTextField.textColor = .black
        newTextField.font = UIFont.title3
        newTextField.textAlignment = .center
        newTextField.backgroundColor = .white
        newTextField.keyboardType = .asciiCapable
        newTextField.autocapitalizationType = .allCharacters
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return newTextField
    }
    
    @objc private func backButtonTapped() {
        buttonAction?()
    }
}
