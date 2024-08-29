//
//  MyButton.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyButton: UIView {
    
    var newButton = UIButton()
    
    init(newButton: UIButton = UIButton()) {
        self.newButton = newButton
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        newButton.setTitle("Button", for: .normal)
        newButton.titleLabel?.font = UIFont.boldTitle2
        newButton.tintColor = .white
        newButton.layer.cornerRadius = 10
        newButton.backgroundColor = UIColor.color0080FF

        addSubview(newButton)
        
        newButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newButton.topAnchor.constraint(equalTo: topAnchor),
            newButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            newButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
