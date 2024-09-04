//
//  LoadingAnimationScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/4.
//

import UIKit

class LoadingAnimationScreen: MyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
//MARK: - subView
extension LoadingAnimationScreen {
    
    private func setupUI() {
        
        let myTitleBar = MyTitleBar(text: "Loading應用")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let startButton = MyButton(text: "顯示加載視窗")
        startButton.buttonAction = { [weak self] in self?.fetchData() }
        
        let subScreen = UIView()
        subScreen.backgroundColor = .clear
        subScreen.addSubview(startButton)
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, subScreen])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
            
            startButton.centerXAnchor.constraint(equalTo: subScreen.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: subScreen.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 175),
            startButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
