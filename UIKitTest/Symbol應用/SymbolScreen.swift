//
//  SymbolScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/10.
//

import UIKit

class SymbolScreen: MyViewController {

    private let titleBar = MyTitleBar()
    private let symbolView = SymbolUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - subView
extension SymbolScreen {
    
    private func setupUI(){
        
        titleBar.setTitle = "SFSymbol應用"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
            
        let appScreen = MyStack(arrangedSubviews: [titleBar, symbolView])
        
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            symbolView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}

