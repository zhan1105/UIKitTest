//
//  MyPackageButton.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/12.
//

import UIKit

class MyPackageButton: UIView {
    
    private var padding: UIEdgeInsets = .zero
    private var newPackageView = UIView()
    
    var button = MyButton()
    
    var textColor: UIColor = .white {
        didSet {
            button.setTitleColor(textColor, for: .normal)
        }
    }
    
    var buttonBackground: UIColor = .oceanBlue {
        didSet {
            button.backgroundColor = buttonBackground
        }
    }
    
    var buttonAction: (() -> Void)? {
        didSet {
            button.buttonAction = buttonAction
        }
    }
    
    init(text: String = ""){
        super.init(frame: .zero)
        setupUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: MyPackageImage) has not been implemented")
    }
    
    private func setupUI(text: String){
        
        button.setTitle(text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        newPackageView.addSubview(button)
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
        NSLayoutConstraint.deactivate(button.constraints) // 清除舊約束
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: newPackageView.topAnchor, constant: padding.top),
            button.bottomAnchor.constraint(equalTo: newPackageView.bottomAnchor, constant: -padding.bottom),
            button.leadingAnchor.constraint(equalTo: newPackageView.leadingAnchor, constant: padding.left),
            button.trailingAnchor.constraint(equalTo: newPackageView.trailingAnchor, constant: -padding.right)
        ])
    }
}
