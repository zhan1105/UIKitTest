//
//  DownMenuScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class DownMenuScreen: MyViewController {
    
    private let titleBar = MyTitleBar()

    let downMenuItem = DownMenuItem().menuData
    
    var selectedOption = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

//MARK: - UI
extension DownMenuScreen {
    private func setupUI() {
       
        titleBar.setTitle = "DownMenu練習"
        titleBar.backButtonAction = { [weak self] in self?.popViewController()}
        
        let subScreen = DownMenuUI()
        subScreen.textFieldDelegate = self
        
        let downMenu = subScreen.downMenu
        let menuButton = subScreen.menuButton
        
        menuButton.menu = UIMenu(children: downMenuItem.map { item in
            UIAction(title: item.name, image: item.image) { [weak self] _ in
                self?.selectedOption = item.name
                downMenu.text = self?.selectedOption
            }
        })
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, subScreen])
        appScreen.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension DownMenuScreen: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // 禁用鍵盤輸入，返回 false 阻止鍵盤彈出
        return false
    }
}
