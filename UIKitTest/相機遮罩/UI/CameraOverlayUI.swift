//
//  CameraOverlayUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/5.
//

import UIKit

class CameraOverlayUI: UIView {

    var targetView = UIView()
    var cameraButton = MyButton()
    var switchButton = MyButton()
    var showImageView = MyImage()
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        targetView.layer.borderWidth = 2
        targetView.layer.borderColor = UIColor.red.cgColor
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.isUserInteractionEnabled = false // 不影響相機操作
        
        cameraButton.setSymbolConfiguration(.camera, size: 50, for: .normal)
        cameraButton.backgroundColor = .clear
        
        switchButton.setSymbolConfiguration(.arrow_camera, size: 24, for: .normal)
        switchButton.backgroundColor = .clear

        let spacer = MySpacer()
        
        let bottomStack = MyStack(arrangedSubviews: [spacer, cameraButton, switchButton])
        bottomStack.axis = .horizontal
        bottomStack.backgroundColor = .black.withAlphaComponent(0.9)
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        let overlayView = MyStack(arrangedSubviews: [targetView, showImageView, bottomStack])
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6) // 半透明黑色
        overlayView.alignment = .center
        
        addSubview(overlayView)
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            targetView.heightAnchor.constraint(equalTo: overlayView.heightAnchor, multiplier: 0.4),
            targetView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 10),
            targetView.bottomAnchor.constraint(equalTo: showImageView.topAnchor, constant: -10),
            targetView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 10),
            targetView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -10),
            
            showImageView.heightAnchor.constraint(equalTo: overlayView.heightAnchor, multiplier: 0.4),
            
            bottomStack.heightAnchor.constraint(equalTo: overlayView.heightAnchor, multiplier: 0.15),
            bottomStack.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
            
            spacer.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.3),
            cameraButton.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.4),
            switchButton.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.3)
        ])
    }
}
