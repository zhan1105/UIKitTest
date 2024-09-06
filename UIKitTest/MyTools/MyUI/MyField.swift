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
    
    private let newTextField = MyTextField()
    private let errorLabel = MyLabel()
    
    init(placeholder: String = "", error: String = ""){
        super.init(frame: .zero)
        setupUI(placeholder: placeholder, error: error)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(placeholder: String, error: String){
        
        // 設定 TextField
        newTextField.placeholder = placeholder
        newTextField.font = UIFont.callout
        newTextField.textAlignment = .left
        newTextField.textPadding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        errorLabel.text = error
        errorLabel.textColor = .red
        errorLabel.font = UIFont.callout
        errorLabel.textAlignment = .right
        errorLabel.isHidden = !shouldShowError
        errorLabel.backgroundColor = .clear
        
        let editView = MyStack(arrangedSubviews: [newTextField, errorLabel])
        editView.backgroundColor = .clear
        editView.isLayoutMarginsRelativeArrangement = true
        editView.padding(to: 10)
        
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
}
