//
//  BarcodeAlert.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/13.
//

import UIKit

class BarcodeAlert: MyViewController {
    
    private let appScreen = MyStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setMyBackgroundColor(.charcoalBlack.withAlphaComponent(0.6))
        setupUI()
        setupGesture()
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.appScreen.addArrangedSubview(view)
        }
    }
}

//MARK: - UI
extension BarcodeAlert {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        appScreen.backgroundColor = .pureWhite
        appScreen.layer.cornerRadius = 10
        appScreen.distribution = .equalSpacing
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            appScreen.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            appScreen.widthAnchor.constraint(equalToConstant: width * 0.95),
        ])
    }
    
    private func setupGesture() {
        // 整個視圖的手勢
        let tapOutsideGesture = UITapGestureRecognizer(target: self, action: #selector(outsideTapped))
        tapOutsideGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapOutsideGesture)
    }
    
    @objc private func outsideTapped() {
        self.dismissOverlay()
    }
}
