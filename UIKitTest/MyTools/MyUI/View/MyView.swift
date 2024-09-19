//
//  MyView.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/12.
//

import UIKit

class MyView: UIView {

    init(addSubview: UIView? = nil) {
        super.init(frame: .zero)
        setupUI(addSubview: addSubview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(addSubview: UIView?) {
        if let subview = addSubview {
            self.addSubview(subview)
        }
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
