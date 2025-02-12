//
//  ScreenShotScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/12.
//

import UIKit

class ScreenShotScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let myLabel = MyLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(screenshotWarning), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        setupUI()
    }
    
    //MARK: - 截圖警示
    @objc func screenshotWarning() {
        
        let remindText: String = "提醒"
        let Screenshot_Reminder: String = "此畫面請自行保留，切勿分享。"
        
        let alert = UIAlertController(title: remindText, message: Screenshot_Reminder, preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

//MARK: - UI
extension ScreenShotScreen {
    private func setupUI() {
        
        titleBar.setTitle = "截圖警示"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        myLabel.text = "截個圖試試吧！"
        myLabel.font = .boldTitle2
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, myLabel])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            myLabel.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}
