//
//  DownMenuScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/20.
//

import UIKit

class DownMenuScreen: MyViewController, UITextFieldDelegate {
    
    let imageNameItem = ImageNameItem().imageData
    
    var selectedOption = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

//MARK: - SubView
extension DownMenuScreen {
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "DownMenu練習")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController()}
        
        let subScreen = DownMenuUI()
        subScreen.textFieldDelegate = self
        
        let downMenu = subScreen.downMenu
        let menuButton = subScreen.menuButton
        
        menuButton.menu = UIMenu(children: imageNameItem.map { item in
            UIAction(title: item.name, image: UIImage(named: item.name)) { [weak self] _ in
                self?.selectedOption = item.name
                downMenu.text = self?.selectedOption
            }
        })
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, subScreen])
        
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}
//MARK: - UITextFieldDelegate
extension DownMenuScreen {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // 禁用鍵盤輸入，返回 false 阻止鍵盤彈出
        return false
    }
}
