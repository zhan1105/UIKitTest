//
//  SwitchLanguage.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class SwitchLanguageScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelView = UILabel()
        labelView.text = NSLocalizedString("goodbye_message", comment: "")
        labelView.font = UIFont.title1
        labelView.textColor = UIColor.white
        labelView.textAlignment = .center
        labelView.backgroundColor = UIColor.red
        
        self.view.addSubview(labelView)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        // 创建语言切换按钮
        let changeLanguageButton = UIButton(type: .system)
        changeLanguageButton.setTitle("切换到中文", for: .normal)
        changeLanguageButton.backgroundColor = .blue
        changeLanguageButton.tintColor = .white
        changeLanguageButton.titleLabel?.font = UIFont.title1
        changeLanguageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        
        self.view.addSubview(changeLanguageButton)
        changeLanguageButton.translatesAutoresizingMaskIntoConstraints = false

        let changeLanguageEnglishButton = UIButton(type: .system)
        changeLanguageEnglishButton.setTitle("切换到英文", for: .normal)
        changeLanguageEnglishButton.backgroundColor = .blue
        changeLanguageEnglishButton.tintColor = .white
        changeLanguageEnglishButton.titleLabel?.font = UIFont.title1
        changeLanguageEnglishButton.addTarget(self, action: #selector(changeEnglishLanguage), for: .touchUpInside)
        
        self.view.addSubview(changeLanguageEnglishButton)
        changeLanguageEnglishButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            labelView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            labelView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            labelView.heightAnchor.constraint(equalToConstant: 100),
            
            changeLanguageButton.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 15),
            changeLanguageButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            changeLanguageButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            changeLanguageButton.heightAnchor.constraint(equalToConstant: 100),
            
            changeLanguageEnglishButton.topAnchor.constraint(equalTo: changeLanguageButton.bottomAnchor, constant: 15),
            changeLanguageEnglishButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            changeLanguageEnglishButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            changeLanguageEnglishButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func changeLanguage() {
        LanguageManager.shared.setLanguage("zh-Hant")
    }
    
    @objc func changeEnglishLanguage() {
        LanguageManager.shared.setLanguage("en")
    }
}
