//
//  CameraArcUI.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/1.
//

import UIKit

class CameraViewUI: UIView {

    private(set) var cameraView = MyPackageImage(image: .scanFrame)
    private let arrowImage = MyPackageImage(image: UIImage(systemSymbol: .arrow_down))
    private let showImageView = MyPackageImage()
    private let cameraButton = CameraButtonUI()
    
    var setShowImage: UIImage? = nil {
        didSet {
            showImageView.setImage = setShowImage
        }
    }
    
    func setButtonAction(for type: CameraButtonType, action: (() -> Void)?) {
        switch type {
        case .Camera:
            cameraButton.setButtonAction(for: .Camera, action: action)
        case .CameraTurn:
            cameraButton.setButtonAction(for: .CameraTurn, action: action)
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: CameraArcUI) has not been implemented")
    }
    
    private func setupUI(){
            
        let width = UIScreen.main.bounds.width
        
        cameraView.viewPadding()
        cameraView.setContentMode = .scaleToFill
        cameraView.isUserInteractionEnabled = false
        cameraView.translatesAutoresizingMaskIntoConstraints = false
                
        let spacer01 = MySpacer(.charcoalBlack.withAlphaComponent(0.7))
        let spacer02 = MySpacer(.charcoalBlack.withAlphaComponent(0.7))
        
        let cameraStack = MyStack(arrangedSubviews: [spacer01, cameraView, spacer02])
        cameraStack.axis = .horizontal
        cameraStack.translatesAutoresizingMaskIntoConstraints = false
        
        spacer01.widthAnchor.constraint(equalTo: cameraStack.widthAnchor, multiplier: 0.075).isActive = true
        cameraView.widthAnchor.constraint(equalTo: cameraStack.widthAnchor, multiplier: 0.85).isActive = true
        spacer02.widthAnchor.constraint(equalTo: cameraStack.widthAnchor, multiplier: 0.075).isActive = true
        
        arrowImage.tintColor = .pureWhite
        arrowImage.viewPadding(to: 0, top: 20, bottom: 20)
        arrowImage.backgroundColor = .charcoalBlack.withAlphaComponent(0.7)
        
        showImageView.viewPadding(to: 0, left: width * 0.075, right: width * 0.075)
        showImageView.backgroundColor = .charcoalBlack.withAlphaComponent(0.7)
        
        cameraButton.turnOnSelfie = true
        
        let subScreen = MyStack(arrangedSubviews: [cameraStack, arrowImage, showImageView, cameraButton])
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cameraStack.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.3),
            arrowImage.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.175),
            showImageView.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.3),
            cameraButton.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.225),
        ])
    }
}
