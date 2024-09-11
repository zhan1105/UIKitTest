//
//  UIKitTestVC.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class FirstTestScreen: MyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - subView
extension FirstTestScreen {
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "簡單排版")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let newImage = MyImage(image: .page2)
        let newView = MyView(addSubview: newImage)
        newImage.paddingAnchor(equalTo: newView, left: 25, right: 25)
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, newView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            newView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}
