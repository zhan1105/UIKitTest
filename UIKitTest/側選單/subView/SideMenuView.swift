//
//  SideMenuView.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/5.
//

import UIKit

class SideMenuView: MyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
    }
}
//MARK: - SubView
extension SideMenuView {
    
    private func setupUI(){
        
        let closeButton = MyButton()
        closeButton.setSymbolImage(.arrow_left, for: .normal)
        closeButton.backgroundColor = .clear
        closeButton.buttonAction = { [weak self] in
            guard let parentVC = self?.parent as? SideMenuScreen else { return }
            parentVC.closeMenu()
        }
        
        let menuLabel = MyLabel(text: "側選單")
        menuLabel.textColor = .white
        
        let menuTitle = MyStack(arrangedSubviews: [menuLabel, closeButton])
        menuTitle.axis = .horizontal
        menuTitle.backgroundColor = .gray
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [menuTitle, spacer])
        subScreen.backgroundColor = .white
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(subScreen)
        
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            menuTitle.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.9),
            
            menuLabel.widthAnchor.constraint(equalTo: menuTitle.widthAnchor, multiplier: 0.8),
            closeButton.widthAnchor.constraint(equalTo: menuTitle.widthAnchor, multiplier: 0.2),
        ])
    }
}
