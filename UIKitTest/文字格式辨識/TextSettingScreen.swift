//
//  TextSettingScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/23.
//

import UIKit

class TextSettingScreen: UIViewController, UITextFieldDelegate {
    
    var selectedText = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupBg
        setupUI()
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


