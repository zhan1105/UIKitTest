//
//  SwitchLanguage.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class SwitchLanguageScreen: MyViewController {
    
    let myTitleBar = MyTitleBar()
    let subScreen = SwitchLanguageUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupBg
        setupUI()
        
        // 添加觀察者以在語言更改時更新 UI
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .languageChanged, object: nil)
    }
    
    func switchLanguage(language: SwitchLanguage) {
        switch language {
        case .chinese:
            LanguageManager.shared.setLanguage("zh-Hant")
        case .english:
            LanguageManager.shared.setLanguage("en")
        case .vietnamese:
            LanguageManager.shared.setLanguage("vi")
        case .indonesian:
            LanguageManager.shared.setLanguage("id")
        }
    }
    
    @objc private func updateUI() {
        clearToViewController(HomeScreen())
    }
    
    private func setupUI() {
        myTitleBar.setTitle = NSLocalizedString("SwitchLanguage", comment: "")
        myTitleBar.backButtonAction = { [weak self] in
            self?.popViewController()
        }
        
        subScreen.chineseButtonAction = { [weak self] in
            self?.switchLanguage(language: .chinese)
        }
        subScreen.englishButtonAction = { [weak self] in
            self?.switchLanguage(language: .english)
        }
        subScreen.vietnameseButtonAction = { [weak self] in
            self?.switchLanguage(language: .vietnamese)
        }
        subScreen.indonesianButtonAction = { [weak self] in
            self?.switchLanguage(language: .indonesian)
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
    
    deinit {
        // 移除觀察者
        NotificationCenter.default.removeObserver(self)
    }
}
