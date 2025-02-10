//
//  OTPScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class OTPScreen: MyViewController {
    
    private let  titleBar = MyTitleBar()
    private let  OTPView = OTPViewUI()
    
    private var phoneNumber = String()
    private var verificationCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

//MARK: - UI
extension OTPScreen {
    private func setupUI() {
        
        titleBar.setTitle = "OTP自動填入"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        OTPView.setDelegate(self)
        
        OTPView.setSendButtonAction = { [weak self] in
            guard let self = self else { return }
            Task { await self.sendCode() }
        }
        
        OTPView.setCheckButtonAction = { [weak self] in
            guard let self = self else { return }
            Task { await self.verifyOTP() }
        }
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, OTPView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            OTPView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}

//MARK: - TextField
extension OTPScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let maxLength: Int =  textField == OTPView.getTextField(.otp) ? 6 : 10
        
        if updatedText.count > maxLength {
            return false
        }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let currentLength = textField.text?.count ?? 0

        switch textField {
        case OTPView.getTextField(.otp):
            
            let text = textField.text!
            let attributes: [NSAttributedString.Key: Any] = [
                .kern: 25.0
            ]
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            textField.attributedText = attributedString
            
            OTPView.shouldSend = currentLength == 6 ? true : false
            
        default: break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        OTPView.select_Field(textField, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        OTPView.select_Field(textField, isSelected: false)
    }
}

//MARK: - API
extension OTPScreen {
    private func sendCode() async {
        
        showLoading()
                
        guard let phone = OTPView.getFieldText(.phone), !phone.isEmpty else {
            MyPrint("電話號碼不可為空")
            return
        }
        
        phoneNumber = phone
                
        let body: [String: String] = [
            "country_code": "TWN",
            "phone": phoneNumber
        ]
        
        do {
            let data = try await APIManager.shared.postForm(url: .getPhoneCode, body: body)
            let dataResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                        
            if dataResponse.code == "00" {
                
                let alert = UIAlertController(title: "已發送OTP碼至\n\(phone)", message: nil, preferredStyle: .alert)
                self.present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
                
            } else {
                showMessage(dataResponse.msg)
            }
            
        } catch {
            print("zhan: 請求失敗或解碼失敗：\(error.localizedDescription)")
        }
                
        dismissLoading()
    }
    
    private func verifyOTP() async {
        
        showLoading()
        
        guard let code = OTPView.getFieldText(.otp), !code.isEmpty else {
            return
        }
        verificationCode = code
        
        let body: [String: String] = [
            "phone"         : phoneNumber,
            "phone_code"    : verificationCode
        ]
        
        MyPrint(body)
        
        do {
            
            let data = try await APIManager.shared.postForm(url: .checkPhoneCode, body: body)
            let dataState = try JSONDecoder().decode(ApiResponse.self, from: data)
            
            let message = dataState.code == "00" ? "驗證成功" : "驗證失敗"
            
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                self.present(alert, animated: true, completion: nil)
            }
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true)

            OTPView.clearFieldText()
            OTPView.shouldSend = false
            
        } catch {
            print("zhan: 請求失敗或解碼失敗：\(error.localizedDescription)")
        }
        
        dismissLoading()
    }
}
