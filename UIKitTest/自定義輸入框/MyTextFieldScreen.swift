//
//  MyTextFieldScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/6.
//

import UIKit

class MyTextFieldScreen: MyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}
//MARK: - subView
extension MyTextFieldScreen {
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "自定義輸入框")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let editView = MyField(placeholder: "測試", error: "錯誤")
        editView.shouldShowError = true
        editView.translatesAutoresizingMaskIntoConstraints = false // 確保自動佈局工作

        let edit = UIView()
        edit.addSubview(editView)
        edit.translatesAutoresizingMaskIntoConstraints = false
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, edit])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            edit.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
            
            editView.centerXAnchor.constraint(equalTo: edit.centerXAnchor),
            editView.centerYAnchor.constraint(equalTo: edit.centerYAnchor),
            editView.widthAnchor.constraint(equalTo: edit.widthAnchor, constant: -20),
            editView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
