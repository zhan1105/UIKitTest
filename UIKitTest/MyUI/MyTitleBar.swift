//
//  MyTitleBar.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/26.
//
import UIKit

class MyTitleBar: UIView {
    
    var titleLabel = UILabel()
    var backButton = UIButton(type: .system)
    var spacer = UIView()
    
    var backButtonAction: (() -> Void)?
    
    // 初始化
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.text = "標題"
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.title2.pointSize, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setImage(UIImage(systemName: SFSymbol.arrow_left.rawValue), for: .normal)
        backButton.tintColor = .black
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 設置 spacer
        spacer.backgroundColor = .clear
        spacer.translatesAutoresizingMaskIntoConstraints = false
        
        // 設置 UIStackView
        let titleBarStack = UIStackView(arrangedSubviews: [backButton, titleLabel, spacer])
        titleBarStack.axis = .horizontal
        titleBarStack.distribution = .fill
        titleBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleBarStack)
        
        // 設置 Auto Layout 約束
        NSLayoutConstraint.activate([
            titleBarStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleBarStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleBarStack.topAnchor.constraint(equalTo: topAnchor),
            titleBarStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15),
            titleLabel.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.7),
            spacer.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15)
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonAction?()
    }
}
