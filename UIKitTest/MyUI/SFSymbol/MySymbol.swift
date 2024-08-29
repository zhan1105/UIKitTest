//
//  MySymbol.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MySymbol: UIView {

    var newImage = UIImageView()
    
    init(newImage: UIImageView = UIImageView()) {
        self.newImage = newImage
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        let paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [UIColor.black, UIColor.orange])
        newImage.image = UIImage(systemSymbol: SFSymbol.bell)
        newImage.contentMode = .scaleAspectFit
        
        addSubview(newImage)
        
        newImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newImage.topAnchor.constraint(equalTo: topAnchor),
            newImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            newImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newImage.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
