//
//  SideMenuScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/5.
//

import UIKit

class SideMenuScreen: MyViewController {
    
    var isSideMenuVisible = false
    var sideMenuView: SideMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}
//MARK: - subView
extension SideMenuScreen{
    private func setupUI() {
        
        let myTitleBar = MyTitleBar(text: "側選單應用")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let startButton = MyButton(text: "開啟側選單")
        startButton.buttonAction = { [weak self] in self?.openMenu() }
        
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

//MARK: - Menu
extension SideMenuScreen{
    private func openMenu() {
        guard !isSideMenuVisible else { return }
        
        let menuView = SideMenuView()
        self.sideMenuView = menuView
        
        menuView.view.frame = CGRect(x: -menuView.view.frame.width, y: 0, width: self.view.frame.width - 100, height: self.view.frame.height)
        menuView.view.backgroundColor = .clear
        
        // 加入 menuView 並將它的 view 蓋在主畫面上
        self.addChild(menuView)
        self.view.addSubview(menuView.view)
        menuView.didMove(toParent: self)
        
        // 使用動畫從左側滑入
        UIView.animate(withDuration: 0.3, animations: {
            menuView.view.frame.origin.x = 0
        }) { [weak self] _ in
            self?.isSideMenuVisible = true
        }
    }
    
    func closeMenu() {
        guard let menuView = self.sideMenuView else { return }
        
        // 使用動畫從右側滑出
        UIView.animate(withDuration: 0.3, animations: {
            menuView.view.frame.origin.x = -menuView.view.frame.width
        }) { [weak self] _ in
            menuView.willMove(toParent: nil)
            menuView.view.removeFromSuperview()
            menuView.removeFromParent()
            self?.isSideMenuVisible = false
        }
    }
}
