//
//  MyTextFieldScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class MyTextFieldScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let myTextField = MyTextFieldUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func verify(){
        
        for textFieldType in TextFieldType.allCases {
            
            let verifyText = myTextField.getFieldText(textFieldType)
            
            switch textFieldType {
            case .appField:
                if let selectText = verifyText, selectText.isEmpty {
                    myTextField.setShowError(textFieldType)
                }
            case .appPassword:
                if let selectText = verifyText, selectText.isEmpty {
                    myTextField.setShowError(textFieldType)
                }
            }
        }
    }
}

//MARK: - UI
extension MyTextFieldScreen {
    private func setupUI() {
        
        titleBar.setTitle = "自定義輸入匡"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        myTextField.setDelegate(self)
        
        myTextField.confirmButtonAction = { [weak self] in self?.verify() }
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, myTextField])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            myTextField.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}

//MARK: - UITextFieldDelegate
extension MyTextFieldScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case myTextField.getTextField(.appField):
            
            let maxLength: Int = 10
            
            // 限制總字數
            if updatedText.count > maxLength {
                return false
            }
            
            let Characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
            let allowedCharacters = CharacterSet(charactersIn: Characters)
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
               
        default:
            return true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let currentLength = textField.text?.count ?? 0
        
        if textField == myTextField.getTextField(.appField) {
            myTextField.appFieldTextCount = currentLength
        }
        
        updateFieldSelection(for: textField, isSelected: true)
    }
    
    func updateFieldSelection(for textField: UITextField, isSelected: Bool) {
        switch textField {
        case myTextField.getTextField(.appField):
            myTextField.selectField(.appField, isSelect: isSelected)
            
        case myTextField.getTextField(.appPassword):
            myTextField.selectField(.appPassword, isSelect: isSelected)

        default:
            break
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFieldSelection(for: textField, isSelected: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateFieldSelection(for: textField, isSelected: false)
    }
}
