//
//  MyStack.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyStack: UIStackView {

    init(arrangedSubviews: [UIView] = [], axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubviews(arrangedSubviews)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        // 任何額外的設置都可以在這裡進行
        // 例如設定背景顏色、邊框等
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
