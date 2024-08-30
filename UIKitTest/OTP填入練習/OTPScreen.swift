//
//  OTPScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/21.
//

import UIKit

class OTPScreen: MyViewController {
    
    let subScreen = OTPCodeUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - SubView
extension OTPScreen {
    
    private func setupUI() {
        
        let myTitleBar = MyTitleBar(text: "OTP自動填入")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        subScreen.textFieldDelegate = self
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, subScreen])

        self.view.backgroundColor = .groupBg
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
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
