//
//  UIView+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/15.
//

import UIKit

extension UIViewController {
    
    // MARK: - 切換畫面
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        viewController.modalPresentationStyle = .fullScreen
        
        if animated {
            // 自訂翻頁動畫
            let transition = CATransition()
            transition.duration = 0.5 // 動畫持續時間
            transition.type = .push // 動畫類型
            transition.subtype = .fromRight // 動畫方向，從右邊翻頁
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // 動畫的時間曲線
            view.window?.layer.add(transition, forKey: kCATransition)
        }
        
        present(viewController, animated: false, completion: nil)
    }
    
    // MARK: - 返回前一頁
    func popViewController(animated: Bool = true) {
        
        if animated {
            // 自訂翻頁動畫
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromLeft
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
        }
        
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - 清空返回首頁
    func clearToViewController(_ mainViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        // 設定 transition
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // 添加動畫到 window 的 layer
        window.layer.add(transition, forKey: kCATransition)

        // 設定新的 rootViewController
        window.rootViewController = mainViewController
    }
}


