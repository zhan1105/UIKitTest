//
//  LoadingAnimationScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/10.
//

import UIKit

class LoadingAnimationScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let startButton = MyPackageButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func fetchData() {
        // 顯示 Loading 畫面
        showLoading()
        
        DispatchQueue.global().async {
            sleep(2) // 模擬網絡請求
            
            DispatchQueue.main.async {
                self.dismissLoading()
            }
        }
    }
}
//MARK: - subView
extension LoadingAnimationScreen {
    
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let height = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        titleBar.setTitle = "Loading應用"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        startButton.buttonText = "顯示加載視窗"
        startButton.viewPadding(to: width * 0.25, top: height * 0.35, bottom: height * 0.35)
        startButton.buttonAction = { [weak self] in self?.fetchData() }
                
        let appScreen = MyStack(arrangedSubviews: [titleBar, startButton])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            startButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}

