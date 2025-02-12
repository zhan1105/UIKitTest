//
//  SideMenuScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/10.
//

import UIKit

class SideMenuScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let startButton = MyPackageButton()

    private var sideMenuView: SideMenuView?

    private var isSideMenuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}
//MARK: - subView
extension SideMenuScreen{
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let height = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        titleBar.setTitle = "側選單應用"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        startButton.buttonText = "開啟側選單"
        startButton.viewPadding(to: width * 0.25, top: height * 0.35, bottom: height * 0.35)
        startButton.buttonAction = { [weak self] in self?.openMenu() }
        
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

//MARK: - Menu
extension SideMenuScreen{
    private func openMenu() {
        guard !isSideMenuVisible else { return }
        
        let menuView = SideMenuView()
        self.sideMenuView = menuView
        
        let menuWidth = self.view.frame.width * 0.8
        menuView.view.frame = CGRect(x: -menuView.view.frame.width, y: 0, width: menuWidth, height: self.view.frame.height)
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
