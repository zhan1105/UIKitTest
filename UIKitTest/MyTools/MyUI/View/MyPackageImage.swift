//
//  MyPackageImage.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/11.
//

import UIKit

class MyPackageImage: UIView {
    
    private var padding: UIEdgeInsets = .zero
    
    private var newImage = MyImage()
    private var newPackageView = UIView()
    
    var setImage: UIImage? = nil {
        didSet {
            newImage.image = setImage
        }
    }
    
    var setContentMode: UIView.ContentMode? = .scaleAspectFit {
        didSet {
            newImage.contentMode = setContentMode!
        }
    }
    
    var isHiddenImage: Bool = false {
        didSet {
            newImage.isHidden = isHiddenImage
        }
    }
    
    init(image: UIImage? = nil){
        super.init(frame: .zero)
        setupUI(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: MyPackageImage) has not been implemented")
    }
    
    private func setupUI(image: UIImage?){
        
        newImage.image = image
        newImage.translatesAutoresizingMaskIntoConstraints = false
        
        newPackageView.addSubview(newImage)
        newPackageView.backgroundColor = .clear
        newPackageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(newPackageView)
        NSLayoutConstraint.activate([
            newPackageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newPackageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newPackageView.topAnchor.constraint(equalTo: topAnchor),
            newPackageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func viewPadding(padding: CGFloat = 0,
                     top: CGFloat? = nil, bottom: CGFloat? = nil,
                     left: CGFloat? = nil, right: CGFloat? = nil){
        self.padding = UIEdgeInsets(
            top:    top     ?? padding,
            left:   left    ?? padding,
            bottom: bottom  ?? padding,
            right:  right   ?? padding
        )
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.deactivate(newImage.constraints) // 清除舊約束
        NSLayoutConstraint.activate([
            newImage.topAnchor.constraint(equalTo: newPackageView.topAnchor, constant: padding.top),
            newImage.bottomAnchor.constraint(equalTo: newPackageView.bottomAnchor, constant: -padding.bottom),
            newImage.leadingAnchor.constraint(equalTo: newPackageView.leadingAnchor, constant: padding.left),
            newImage.trailingAnchor.constraint(equalTo: newPackageView.trailingAnchor, constant: -padding.right)
        ])
    }
}
