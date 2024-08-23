//
//  DownMenuScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/20.
//

import UIKit

class DownMenuScreen: UIViewController, UITextFieldDelegate {
    
    var imageNameItem = ImageNameItem().imageData
    
    var selectedOption = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - SubView
extension DownMenuScreen {
    
    var titleBar: UIStackView {
        
        let titleLabel = mainLabelView(labelText: "DownMenu練習", font: .title1, isBold: true, _textColor: .black, aligment: .center, background: .clear)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = mainArrowButtonView(symbol: .arrow_left, target: self, action: #selector(back))
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleBarStack = UIStackView(arrangedSubviews: [backButton, titleLabel, view])
        titleBarStack.axis = .horizontal
        titleBarStack.distribution = .fill
        titleBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.7).isActive = true
        view.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        
        return titleBarStack
    }
    
    var downMenu: UITextField {
        
        let editText = UITextField()
        editText.borderStyle = .none
        editText.placeholder = "請選擇一個項目"
        editText.text = selectedOption
        editText.textColor = .black
        editText.font = UIFont.title2
        editText.backgroundColor = .clear
        editText.delegate = self
        
        let menuButton = UIButton(type: .system)
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        menuButton.tintColor = .black
        
        menuButton.menu = UIMenu(children: imageNameItem.map { item in
            UIAction(title: item.name, image: UIImage(named: item.name)) { [weak self] _ in
                self?.selectedOption = item.name
                editText.text = self?.selectedOption
            }
        })
        
        editText.rightView = menuButton
        editText.rightViewMode = .always
        editText.translatesAutoresizingMaskIntoConstraints = false

        return editText
    }
    
    var screen: UIStackView {
        
        let downMenu = downMenu
        
        let spaceView = mainSpacer()
        
        let subView = UIStackView(arrangedSubviews: [downMenu, spaceView])
        subView.axis = .vertical
        subView.distribution = .fill
        subView.alignment = .center
        subView.backgroundColor = .groupBg
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            downMenu.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.1),
            spaceView.heightAnchor.constraint(equalTo: subView.heightAnchor, multiplier: 0.9),
            
            downMenu.topAnchor.constraint(equalTo: subView.topAnchor, constant: 15),
            downMenu.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 15),
            downMenu.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -15),
            downMenu.bottomAnchor.constraint(equalTo: spaceView.topAnchor, constant: -15)
        ])
        
        return subView
    }
}

//MARK: - Function
extension DownMenuScreen {
    
    @objc func back() {
        popView()
    }
    
    private func setupUI(){
        
        let titleBar = titleBar
        let screen = screen
        
        let appScreen = UIStackView(arrangedSubviews: [titleBar, screen])
        appScreen.axis = .vertical
        appScreen.distribution = .fill
        
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            screen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
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
