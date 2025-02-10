//
//  MyTitleBar.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyTitleBar: UIView {
    
    private var titleLabel = MyLabel()
    private var backButton = UIButton(type: .system)
    
    var backButtonAction: (() -> Void)?
    
    var setTitle: String? = nil {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    // 初始化
    init(text: String = "標題") {
        super.init(frame: .zero)
        setupViews(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(text: String) {
        
        titleLabel.text = text
        titleLabel.font = .boldTitle2
        
        backButton.setImage(UIImage(systemSymbol: SFSymbol.arrow_left), for: .normal)
        backButton.tintColor = .black
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [backButton, titleLabel, spacer])
        subScreen.axis = .horizontal
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15),
            titleLabel.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.7),
            spacer.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15)
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonAction?()
    }
}

