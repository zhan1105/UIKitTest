//
//  MyViewButton.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/11.
//

import UIKit

class MyImageButton: UIButton {
    
    var buttonAction: (() -> Void)?
    
    init(image: UIImage? = nil) {
        super.init(frame: .zero)
        setupUI(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(image: UIImage?) {
        self.setImage(image, for: .normal)
        self.setTitle("", for: .normal)
        self.tintColor = .clear
        self.backgroundColor = .clear
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
