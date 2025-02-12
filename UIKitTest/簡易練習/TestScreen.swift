//
//  TestScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class TestScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let pictureImage = MyPackageImage()
    private let changeButton = MyPackageButton()
    
    private let pictureItem: [UIImage] = [.page1, .page2, .page3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func changePicture() {
        guard let currentImage = pictureImage.setImage else {
            pictureImage.setImage = pictureItem.randomElement()
            return
        }
        
        var newImage: UIImage?
        
        repeat {
            newImage = pictureItem.randomElement()
        } while newImage == currentImage
        
        pictureImage.setImage = newImage
    }
}

//MARK: - UI
extension TestScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        titleBar.setTitle = "簡易練習"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        pictureImage.setImage = .page3
        pictureImage.viewPadding(to: width * 0.01)
        
        changeButton.buttonText = "換一張"
        changeButton.viewPadding(to: width * 0.05)
        changeButton.buttonAction = { [weak self] in self?.changePicture() }
        
        let spacer = MySpacer()
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, pictureImage, changeButton, spacer])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            pictureImage.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.45),
            changeButton.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.15),
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.3),
        ])
    }
}
