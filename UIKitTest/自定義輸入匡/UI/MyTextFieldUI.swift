//
//  MyTextFieldUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class MyTextFieldUI: UIView {

    private let appField = AppField()
    private let appPassword = AppPassword()
    private let confirmButton = MyPackageButton()
    private let clearButton = MyPackageButton()
    
    var appFieldTextCount: Int = 0 {
        didSet {
            appField.textCount = appFieldTextCount
        }
    }
    
    var confirmButtonAction: (() -> Void)? {
        didSet {
            confirmButton.buttonAction = confirmButtonAction
        }
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate){
        appField.setDelegate(delegate)
        appPassword.setDelegate(delegate)
    }
    
    func getTextField(_ type: TextFieldType) -> UITextField? {
        switch type {
        case .appField:
            appField.newTextField
        case .appPassword:
            appPassword.newTextField
        }
    }
    
    func getFieldText(_ type: TextFieldType) -> String? {
        switch type {
        case .appField:
            appField.fieldText
        case .appPassword:
            appPassword.fieldText
        }
    }
    
    func selectField(_ type: TextFieldType, isSelect: Bool) {
        switch type {
        case .appField:
            appField.isSelect = isSelect
        case .appPassword:
            appPassword.isSelect = isSelect
        }
    }
    
    func setShowError(_ type: TextFieldType) {
        switch type {
        case .appField:
            appField.shouldShowError = true
            appField.errorText = "請輸入帳號"
        case .appPassword:
            appPassword.shouldShowError = true
            appPassword.errorText = "請輸入密碼"
        }
    }
    
    func clearTextField() {
        appField.fieldText = ""
        appField.shouldShowError = false
        
        appPassword.fieldText = ""
        appPassword.shouldShowError = false
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: MyTextFieldUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        appField.setIcon = .idCard
        appField.textTotalCount = 10
        appField.setKeyboardType = .asciiCapable
        appField.setAutocapitalizationType = .allCharacters
        appField.setPlaceholder = "請輸入帳號"
        
        appPassword.setPlaceholder = "請輸入密碼"
        
        let spacer = MySpacer()
        
        confirmButton.buttonText = "confirm"
        confirmButton.viewPadding(to: width * 0.05, top: width * 0.075, bottom: width * 0.025)
        
        clearButton.buttonText = "Clear"
        clearButton.buttonBackground = .coralRed
        clearButton.viewPadding(to: width * 0.05, top: width * 0.025, bottom: width * 0.075)
        clearButton.buttonAction = { [weak self] in self?.clearTextField() }
        
        let subScreen = MyStack(arrangedSubviews: [appField, appPassword, spacer, confirmButton, clearButton])
        subScreen.alignment = .center
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            appField.widthAnchor.constraint(equalToConstant: width * 0.9),
            appField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.125),
            
            appPassword.widthAnchor.constraint(equalToConstant: width * 0.9),
            appPassword.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.125),
            
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.45),
            
            confirmButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            confirmButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            
            clearButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            clearButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15)
        ])
    }
}
