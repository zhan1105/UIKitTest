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
        
        let image = MyImageUrl(imageURL: "https://cdn2.thecatapi.com/images/1a6.gif", shouldCache: true)
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, image])
        
        self.view.addSubview(appScreen)
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            image.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
    
}

