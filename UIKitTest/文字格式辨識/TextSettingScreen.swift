//
//  TextSettingScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/23.
//

import UIKit

class TextSettingScreen: UIViewController {
    
    let myTitleBar = MyTitleBar()
    let subScreen = TextSettingUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupBg
        setupUI()
    }
    
    func checkTextFormat(){
        
        enum ErrorMessage {
            case isEmpty
            case firstTextField
            case secondTextField
            case thirdTextField
            
            func message(for textField: UITextField?) -> String {
                switch self {
                case .isEmpty:
                    return "輸入內容不可為空"
                case .firstTextField:
                    return textField?.placeholder ?? "未知錯誤"
                case .secondTextField:
                    return textField?.placeholder ?? "未知錯誤"
                case .thirdTextField:
                    return textField?.placeholder ?? "未知錯誤"
                }
            }
        }
        
        clearHighlight(for: subScreen.firstTextField)
        clearHighlight(for: subScreen.secondTextField)
        clearHighlight(for: subScreen.thirdTextField)
        
        if let selectedText = subScreen.firstTextField.text {
            
            if selectedText.isEmpty {
                let error = ErrorMessage.isEmpty
                showMessage(title: "錯誤提醒", message: "第一格 \(error.message(for: subScreen.firstTextField))", for: subScreen.firstTextField)

                return
            } else {
                let regex = "^[A-Z][A-Z0-9][0-9]{8}$"
                let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
                
                if predicate.evaluate(with: selectedText) {
                    print("success")
                } else {
                    let error = ErrorMessage.firstTextField
                    showMessage(title: "格式錯誤", message: error.message(for: subScreen.firstTextField), for: subScreen.firstTextField)
                    
                    subScreen.firstTextField.becomeFirstResponder()
                    highlightTextField(subScreen.firstTextField)
                    return
                }
            }
        }
        
        if let secondSelectedText = subScreen.secondTextField.text {
            if secondSelectedText.isEmpty {
                let error = ErrorMessage.isEmpty
                showMessage(title: "錯誤提醒", message: "第二格\(error.message(for: subScreen.secondTextField))", for: subScreen.secondTextField)
                return
            } else {
                print("success2")
            }
        }
        
        if let thirdSelectedText = subScreen.thirdTextField.text {
            if thirdSelectedText.isEmpty {
                let error = ErrorMessage.isEmpty
                showMessage(title: "錯誤提醒", message: "第三格\(error.message(for: subScreen.secondTextField))", for: subScreen.thirdTextField)
                return
            } else {
                
                let regex = "^[A-Z][0-9]{9}$"
                let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
                
                if predicate.evaluate(with: thirdSelectedText) {
                    print("success3")
                }else {
                    let error = ErrorMessage.thirdTextField
                    showMessage(title: "錯誤提醒", message: error.message(for: subScreen.thirdTextField), for: subScreen.thirdTextField)
                    return
                }
            }
        }
    }
}
extension TextSettingScreen {
    
    private func setupUI(){
        
        myTitleBar.titleLabel.text = "文字辨識"
        myTitleBar.backButtonAction = { self.popView() }
        
        subScreen.firstTextField.delegate = self
        subScreen.secondTextField.delegate = self
        subScreen.thirdTextField.delegate = self
        subScreen.buttonAction = { self.checkTextFormat() }
        
        let appScreen = UIStackView(arrangedSubviews: [myTitleBar, subScreen])
        appScreen.axis = .vertical
        appScreen.distribution = .fill
        
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
            
            myTitleBar.leadingAnchor.constraint(equalTo: appScreen.leadingAnchor),
            myTitleBar.trailingAnchor.constraint(equalTo: appScreen.trailingAnchor),
            
            subScreen.leadingAnchor.constraint(equalTo: appScreen.leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: appScreen.trailingAnchor),
        ])
    }
}

extension TextSettingScreen: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        // 計算更新後的字串長度
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == subScreen.firstTextField || textField == subScreen.thirdTextField {
            // 限制總字數為10
            return updatedText.count <= 10
        } else if textField == subScreen.secondTextField {
            // 限制只能輸入大寫英文
            let allowedCharacters = CharacterSet.uppercaseLetters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}
