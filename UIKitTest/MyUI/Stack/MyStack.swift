//
//  MyStack.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyStack: UIView {

    var newStack: UIStackView
    
    init(arrangedSubviews: [UIView] = []) {
        self.newStack = UIStackView(arrangedSubviews: arrangedSubviews)
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        newStack.axis = .vertical
        newStack.distribution = .fill
        newStack.backgroundColor = .clear
        
        addSubview(newStack)
        
        newStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newStack.topAnchor.constraint(equalTo: topAnchor),
            newStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            newStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            newStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
