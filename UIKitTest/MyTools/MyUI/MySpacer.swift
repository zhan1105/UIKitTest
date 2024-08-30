//
//  MySpacer.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class MySpacer: UIView {
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
