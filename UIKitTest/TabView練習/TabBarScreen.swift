//
//  TabViewScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/11.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mintGreen
        self.title = "First"
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .oceanBlue
        self.title = "Second"
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .coralRed
        self.title = "Third"
    }
}

class TabBarScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let screenView = UIView()
    private let tabBar = UITabBar()
    
    private let firstVC = FirstViewController()
    private let secondVC = SecondViewController()
    private let thirdVC = ThirdViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
               
        // 設定 tab bar 項目
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
     
        
        setupUI()
    }
}

//MARK: - UI
extension TabBarScreen {
    private func setupUI() {
        
        titleBar.setTitle = "TabBar練習"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        tabBar.delegate = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let firstTab = UITabBarItem(title: "首頁", image: UIImage(systemSymbol: .home), tag: 0)
        let secondTab = UITabBarItem(title: "清單", image: UIImage(systemSymbol: .list), tag: 1)
        let thirdTab = UITabBarItem(title: "設定", image: UIImage(systemSymbol: .gearshape), tag: 2)
        
        tabBar.items = [firstTab, secondTab, thirdTab]
        tabBar.selectedItem = firstTab
        switchToViewController(firstVC)
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, screenView, tabBar])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            screenView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.825),
            tabBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.075),
        ])
    }
}

//MARK: - UITabBarDelegate
extension TabBarScreen: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            switchToViewController(firstVC)
        case 1:
            switchToViewController(secondVC)
        case 2:
            switchToViewController(thirdVC)
        default:
            break
        }
    }
    
    // 切換子畫面
    private func switchToViewController(_ screen: UIViewController) {
        // 移除當前的子視圖
        children.forEach { $0.view.removeFromSuperview(); $0.removeFromParent() }
        self.screenView.subviews.forEach { $0.removeFromSuperview() }
        
        addChild(screen)
        self.screenView.addSubview(screen.view) // 將子視圖添加到 screenView 中
        screen.view.frame = self.screenView.bounds // 設置子視圖的框架
        screen.view.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 允許自動調整大小
        screen.didMove(toParent: self)
    }
}
