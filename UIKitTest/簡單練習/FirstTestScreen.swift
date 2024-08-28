//
//  UIKitTestVC.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class FirstTestScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newButton = UIButton(type: .system)
        newButton.setTitle("Button", for: .normal)
        newButton.titleLabel?.font = UIFont.boldTitle2
        newButton.tintColor = .white
        newButton.setImage(UIImage(systemName: SFSymbol.arrow_left.rawValue), for: .normal)
        newButton.backgroundColor = UIColor.color0080FF
        newButton.layer.cornerRadius = 10
        newButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(newButton)
        
        newButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 325),
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -325),
            newButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 125),
            newButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -125)
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        popView()
    }
}
