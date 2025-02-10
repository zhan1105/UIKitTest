//
//  OTPViewUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class OTPViewUI: UIView {
    
    private let phoneField = AppField()
    private let otpField = AppField()
    
    private let sendButton = MyPackageButton()
    private let checkButton = MyPackageButton()
    
    var setSendButtonAction: (() -> Void)? {
        didSet {
            sendButton.buttonAction = setSendButtonAction
        }
    }
    
    var setCheckButtonAction: (() -> Void)? {
        didSet {
            checkButton.buttonAction = setCheckButtonAction
        }
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate) {
        phoneField.setDelegate(delegate)
        otpField.setDelegate(delegate)
    }
    
    enum FieldType {
        case phone
        case otp
    }
    
    func getTextField(_ type: FieldType) -> UITextField {
        switch type {
        case .phone:
            phoneField.newTextField
        case .otp:
            otpField.newTextField
        }
    }
    
    func getFieldText(_ type: FieldType) -> String? {
        switch type {
        case .phone:
            phoneField.fieldText
        case .otp:
            otpField.fieldText
        }
    }
    
    func select_Field(_ textField: UITextField, isSelected: Bool) {
        switch textField {
        case phoneField.newTextField:
            phoneField.isSelect = isSelected
        case otpField.newTextField:
            otpField.isSelect = isSelected
        default:
            break
        }
    }
    
    func clearFieldText() {
        phoneField.fieldText = ""
        otpField.fieldText = ""
    }
    
    var shouldSend: Bool = false {
        didSet {
            checkButton.buttonBackground = shouldSend ? .oceanBlue : .softGray
            checkButton.buttonEnabled = shouldSend
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: OTPViewUI) has not been implemented")
    }
    
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        phoneField.setIcon = .phone
        phoneField.setPlaceholder = "手機號碼"
        phoneField.setKeyboardType = .numberPad
        phoneField.setAutocapitalizationType = .allCharacters
        
        sendButton.buttonText = "寄送"
        sendButton.viewPadding(to: width * 0.05, top: 0, bottom: width * 0.1)
        
        otpField.setIcon = .message
        otpField.fieldFont = .boldHeadline
        otpField.setKeyboardType = .numberPad
        otpField.fieldContentType = .oneTimeCode
        otpField.fieldAlignment = .center
        otpField.fieldRightViewMode = .never
        
        checkButton.buttonText = "驗證OTP"
        checkButton.viewPadding(to: width * 0.05, top: width * 0, bottom: width * 0.1)
        checkButton.buttonBackground = .softGray
        checkButton.buttonEnabled = false
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [phoneField, sendButton, otpField, checkButton, spacer])
        subScreen.alignment = .center
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            phoneField.widthAnchor.constraint(equalToConstant: width * 0.9),
            phoneField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.125),
            
            sendButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            sendButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            
            otpField.widthAnchor.constraint(equalToConstant: width * 0.9),
            otpField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.125),
            
            checkButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor),
            checkButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.15),
            
            spacer.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.45)
        ])
    }

}
