//
//  CollectionCell.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/14.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    private let pictureImage = MyPackageImage()
    private let titleLabel = MyLabel()
    private let subScreen = MyStack()
    
    var setImage: UIImage? {
        didSet {
            pictureImage.setImage = setImage
        }
    }
    
    var setTitle: String? {
        didSet {
            titleLabel.text = setTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
                
        let width = UIScreen.main.bounds.width
        
        pictureImage.viewPadding(to: 10)
        
        titleLabel.font = .headline
        
        subScreen.addArrangedSubviews([pictureImage, titleLabel])
        subScreen.backgroundColor = .lightGrayWhite
        subScreen.layer.cornerRadius = 15
        subScreen.layer.borderWidth = 1
        subScreen.layer.borderColor = UIColor.oceanBlue.cgColor
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor, constant: width * 0.025),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -width * 0.025),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor, constant: width * 0.025),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -width * 0.025),
            
            pictureImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.8),
            titleLabel.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.2),
        ])
    }
}
