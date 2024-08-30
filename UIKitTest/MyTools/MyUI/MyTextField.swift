//
//  MyTextField.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyTextField: UITextField {

    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.text = ""
        self.textColor = .black
        self.placeholder = "TextField"
        self.borderStyle = .none
        self.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.layer.cornerRadius = 10
        self.font = UIFont.boldTitle2
        self.textAlignment = .center
        self.backgroundColor = .white
    }
    
    var textPadding: UIEdgeInsets = .zero
    
    // 控制非編輯狀態下的文字顯示範圍
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // 控制編輯狀態下的文字顯示範圍
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // 控制佈局字元顯示的範圍（如佔位符）
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    // 控制 rightView 的顯示範圍
        override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            let width = rightView?.frame.width ?? 0
            return CGRect(x: bounds.width - width - 5, y: 0, width: width, height: bounds.height)
        }
        
        // 控制 leftView 的顯示範圍
        override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            let width = leftView?.frame.width ?? 0
            return CGRect(x: bounds.width - width + 5, y: 0, width: width, height: bounds.height)
        }
}
