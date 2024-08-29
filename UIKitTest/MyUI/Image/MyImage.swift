//
//  MyImage.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyImage: UIView {
    
    var newImage = UIImageView()
    
    init(newImage: UIImageView = UIImageView()) {
        self.newImage = newImage
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        newImage.image = UIImage(named: "")
        newImage.contentMode = .scaleAspectFit
        
        addSubview(newImage)
        
        NSLayoutConstraint.activate([
            newImage.topAnchor.constraint(equalTo: topAnchor),
            newImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            newImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newImage.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
