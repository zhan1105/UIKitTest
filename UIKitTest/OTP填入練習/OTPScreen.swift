//
//  OTPScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/21.
//

import UIKit

class OTPScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - SubView
extension OTPScreen {
    
    private func setupUI() {
        
        let titleBar = mainTitleBar(title: "OTP自動填入")
        let subScreen = subScreen
        
        let appScreen = UIStackView(arrangedSubviews: [titleBar, subScreen])
        appScreen.axis = .vertical
        appScreen.distribution = .fill
        
        self.view.backgroundColor = .groupBg
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
    
    var otpTextField: UITextField {
        
        let newTextField = UITextField()
        newTextField.borderStyle = .line
        newTextField.placeholder = "請輸入驗證碼"
        newTextField.textColor = .black
        newTextField.font = UIFont.title2
        newTextField.backgroundColor = .white
        
//        newTextField.keyboardType = .default
        newTextField.textContentType = .oneTimeCode
        newTextField.delegate = self
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return newTextField
    }
    
    var subScreen: UIStackView {
        
        let otpTextField = otpTextField
        let spacerView = mainSpacer()
        
        let subScreen = UIStackView(arrangedSubviews: [otpTextField, spacerView])
        subScreen.axis = .vertical
        subScreen.distribution = .fill
        subScreen.alignment = .center
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            otpTextField.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacerView.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.9),
            
            otpTextField.topAnchor.constraint(equalTo: subScreen.topAnchor, constant: 5),
            otpTextField.bottomAnchor.constraint(equalTo: spacerView.topAnchor, constant: -5),
            otpTextField.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 5),
            otpTextField.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -5)
        ])
        
        return subScreen
    }
}

//MARK: - UITextFieldDelegate
extension OTPScreen: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // 當OTP長度達到你預期的長度時，自動提交或進行其他操作
        if updatedText.count == 6 { // 假設 OTP 是 6 位數
            // 自動提交或其他處理
            print("自動填充的OTP: \(updatedText)")
        }
        
        return true
    }
}
