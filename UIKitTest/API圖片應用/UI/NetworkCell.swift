//
//  NetworkCell.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/11.
//

import UIKit

class NetworkCell: UITableViewCell {

    let pictureImage = MyImageUrl()
    
    var setImageURL: String? {
        didSet {
            if let urlString = setImageURL, let url = URL(string: urlString) {
                pictureImage.setImageURL = url
            } else {
                pictureImage.setImageURL = nil
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        self.selectedBackgroundView = selectedView
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(pictureImage)
        
        NSLayoutConstraint.activate([
            pictureImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            pictureImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            pictureImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            pictureImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
}
