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
        
        if let selectedText = subScreen.firstTextField.text {
            if selectedText.isEmpty {
                let message = subScreen.firstTextField.placeholder ?? "輸入內容不可為空"
                showMessage(title: "錯誤提醒", message: message)
            } else {
                // 使用正則表達式進行檢查
                let regex = "^[A-Z][A-Z0-9][0-9]{8}$"
                let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
                
                if predicate.evaluate(with: selectedText) {
                    showMessage(title: "成功訊息", message: "")
                } else {
                    // selectedText 不符合正則表達式
                    showMessage(title: "格式錯誤", message: "輸入內容的格式不正確")
                }
            }
        }
    }
}
extension TextSettingScreen {
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar()
        myTitleBar.titleLabel.text = "文字辨識"
        myTitleBar.backButtonAction = {
            self.popView()
        }
        
        let subScreen = TextSettingUI()
        
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
