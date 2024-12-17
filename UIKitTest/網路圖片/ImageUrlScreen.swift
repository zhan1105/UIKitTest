//
//  ImageUrlScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/3.
//

import UIKit

class ImageUrlScreen: MyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}
//MARK: - subView
extension ImageUrlScreen {
    
    private func setupUI(){
        let myTitleBar = MyTitleBar(text: "網路圖片應用")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let imageURLString = "https://testaml.mgtt.com.tw/site/familyNetSend/44800019/758AB3883D8739"
        guard let imageURL = URL(string: imageURLString) else {
            print("無效的圖片網址")
            return
        }
        
        // 創建 MyImageUrl 實例
        let myImageView = MyImageUrl(imageURL: imageURL, shouldCache: true)
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, myImageView])
        
        self.view.addSubview(appScreen)
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            myImageView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
    
}

