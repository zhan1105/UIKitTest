//
//  CameraTitleBarUI.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/1.
//

import UIKit

class CameraBackUI: UIView {

    private let backButton = MyImageButton(image: .backWhite)
    var backButtonAction: (() -> Void)?
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: CameraBackUI) has not been implemented")
    }
    
    private func setupUI(){
        
        backButton.setImage(.backWhite, for: .normal)
        backButton.tintColor = .charcoalBlack
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [backButton, spacer])
        subScreen.axis = .horizontal
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.15),
            spacer.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc private func backButtonTapped() {
        backButtonAction?()
    }
}
