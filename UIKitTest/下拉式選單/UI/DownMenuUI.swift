//
//  DownMenuUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class DownMenuUI: UIView {
    
    var downMenu = MyTextField()
    var menuButton = MyButton()
    
    weak var textFieldDelegate: UITextFieldDelegate?
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        downMenu.font = .boldBody
        downMenu.textAlignment = .left
        downMenu.placeholder = "請選擇一個項目"
        downMenu.delegate = textFieldDelegate
        
        menuButton.backgroundColor = .clear
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.setSymbolImage(.ellipsis, for: .normal)
        menuButton.tintColor = .black
        
        downMenu.rightView = menuButton
        downMenu.rightViewMode = .always
        downMenu.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [downMenu, spacer])
        subScreen.alignment = .center
        subScreen.backgroundColor = .groupBg
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            downMenu.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.9),
            
            downMenu.topAnchor.constraint(equalTo: subScreen.topAnchor, constant: 15),
            downMenu.bottomAnchor.constraint(equalTo: spacer.topAnchor, constant: -15),
            downMenu.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            downMenu.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
        ])
    }
}
