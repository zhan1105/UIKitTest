//
//  MyLabel.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyLabel: UIView {
    
    var newLabel = UILabel()

    init(label: UILabel = UILabel()) {
        self.newLabel = label
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        newLabel.text = "Label"
        newLabel.font = UIFont.boldTitle2
        newLabel.textColor = .black
        newLabel.textAlignment = .center
        newLabel.backgroundColor = .clear
        
        addSubview(newLabel)
        
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newLabel.topAnchor.constraint(equalTo: topAnchor),
            newLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            newLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            newLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
