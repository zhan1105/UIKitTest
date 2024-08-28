//
//  SwitchLanguage.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class SwitchLanguageScreen: UIViewController {
    
    let myTitleBar = MyTitleBar()
    let subScreen = SwitchLanguageUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupBg
        setupUI()
    }
    
    func switchLanguage(language: SwitchLanguage) {
        switch language {
        case .chinese:
            LanguageManager.shared.setLanguage("zh-Hant")
        case .english:
            LanguageManager.shared.setLanguage("en")
        }
        
        // 更新當前畫面
        updateUI()
        
        // 或者選擇返回上一頁更新界面
        // self.popView()
    }
    
    private func setAppLanguage(to languageCode: String) {
        // 假設你有一個方法來設置應用的語言
        // LocalizationManager.shared.setLanguage(languageCode)
        // 然後重新加載應用的所有文本
    }
    
    private func updateUI() {
        subScreen.languageLabel.text = NSLocalizedString("Hello", comment: "")
        // 這裡可以更新其他需要本地化的界面元素
    }
}

extension SwitchLanguageScreen {
    
    private func setupUI() {
        
        myTitleBar.titleLabel.text = "語系切換"
        myTitleBar.backButtonAction = { [weak self] in
            self?.popView()
        }
        
        subScreen.chineseButtonAction = { [weak self] in
            self?.switchLanguage(language: .chinese)
        }
        subScreen.englishButtonAction = { [weak self] in
            self?.switchLanguage(language: .english)
        }
        
        let appScreen = UIStackView(arrangedSubviews: [myTitleBar, subScreen])
        appScreen.axis = .vertical
        appScreen.distribution = .fill
        
        view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}
