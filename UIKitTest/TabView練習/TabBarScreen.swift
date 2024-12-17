//
//  TabViewScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/10/17.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "First"
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = "Second"
    }
}

class TabBarScreen: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化視圖控制器
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()

        // 設定 tab bar 項目
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)

        // 將視圖控制器加入 TabBarController
        let controllers = [firstVC, secondVC]
        self.viewControllers = controllers
    }
}
