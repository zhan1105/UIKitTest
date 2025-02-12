//
//  CameraButtonUI.swift
//  transfer
//
//  Created by 紹郁 on 2024/10/1.
//

import UIKit

class CameraButtonUI: UIView {
    
    private let cameraButton = PackageButton()
    private let cameraTurnButton = PackageButton()

    var turnOnSelfie: Bool = false {
        didSet {
            cameraTurnButton.buttonHidden = !turnOnSelfie
        }
    }
    
    func setButtonAction(for type: CameraButtonType, action: (() -> Void)?) {
        switch type {
        case .Camera:
            cameraButton.buttonAction = action
        case .CameraTurn:
            cameraTurnButton.buttonAction = action
        }
    }
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: CameraButtonUI) has not been implemented")
    }
    
    private func setupUI(){
        
        cameraButton.buttonImage = .cameraIcon
        cameraButton.buttonBackground = .clear
        cameraButton.viewPadding(to: 0)
        
        cameraTurnButton.buttonImage = .cameraTurn
        cameraTurnButton.buttonBackground = .clear
        cameraTurnButton.viewPadding(to: 0, top: 10)
        
        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [spacer, cameraButton, cameraTurnButton])
        subScreen.axis = .horizontal
        subScreen.backgroundColor = .charcoalBlack.withAlphaComponent(0.7)
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            spacer.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.3),
            cameraButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.4),
            cameraTurnButton.widthAnchor.constraint(equalTo: subScreen.widthAnchor, multiplier: 0.3),
        ])
    }
}
