//
//  ScreenShotScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/11/8.
//

import UIKit

class ScreenShotScreen: MyViewController {
    
    // 黑色遮罩的 UIView
    private var blackoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.0 // 初始設為透明
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        // 訂閱截圖通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTakeScreenshot),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
        
        // 將黑色遮罩添加到視圖中
        view.addSubview(blackoutView)
        
        // 設定遮罩的約束，讓它覆蓋整個螢幕
        NSLayoutConstraint.activate([
            blackoutView.topAnchor.constraint(equalTo: view.topAnchor),
            blackoutView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blackoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func didTakeScreenshot() {
        // 當偵測到截圖時，立即將遮罩顯示出來
        showBlackoutView()
        
        // 設置稍微延遲後隱藏遮罩，給系統截圖的時間
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.hideBlackoutView()
        }
    }
    
    private func showBlackoutView() {
        UIView.animate(withDuration: 0.1) {
            self.blackoutView.alpha = 1.0
        }
    }
    
    private func hideBlackoutView() {
        UIView.animate(withDuration: 0.1) {
            self.blackoutView.alpha = 0.0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
