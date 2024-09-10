//
//  EditView.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/6.
//

import UIKit

class MyField: UIView {
    
    var shouldShowError: Bool = false {
        didSet {
            errorLabel.isHidden = !shouldShowError
        }
    }
    
    var textCount: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    var textTotalCount: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    var newTextField = MyTextField()
    private let errorLabel = MyLabel()
    private let countLabel = MyLabel()
    private let iconImage = MySymbol(symbol: .arrow_camera)
    
    init(placeholder: String = "", error: String = ""){
        super.init(frame: .zero)
        setupUI(placeholder: placeholder, error: error)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(placeholder: String, error: String){
        
        iconImage.tintColor = .black
        
        countLabel.textColor = .gray
        countLabel.font = UIFont.callout
        updateCountLabel()
        
        // 設定 TextField
        newTextField.placeholder = placeholder
        newTextField.font = UIFont.callout
        newTextField.textAlignment = .left
        newTextField.leftView = iconImage
        newTextField.leftViewMode = .always
        newTextField.rightView = countLabel
        newTextField.rightViewMode = .always
        newTextField.padding(left: 15)
        
        errorLabel.text = error
        errorLabel.textColor = .red
        errorLabel.font = UIFont.callout
        errorLabel.textAlignment = .right
        errorLabel.isHidden = !shouldShowError
        errorLabel.backgroundColor = .clear
        
        let editView = MyStack(arrangedSubviews: [newTextField, errorLabel])
        editView.backgroundColor = .clear
        editView.isLayoutMarginsRelativeArrangement = true
        
        addSubview(editView)
        
        editView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editView.topAnchor.constraint(equalTo: topAnchor),
            editView.bottomAnchor.constraint(equalTo: bottomAnchor),
            editView.leadingAnchor.constraint(equalTo: leadingAnchor),
            editView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            newTextField.topAnchor.constraint(equalTo: topAnchor),
            newTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            newTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            newTextField.heightAnchor.constraint(equalToConstant: 50),  // 可以根據需要調整
            
            errorLabel.topAnchor.constraint(equalTo: newTextField.bottomAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateCountLabel() {
        countLabel.text = "\(textCount)/\(textTotalCount)"
    }
}
