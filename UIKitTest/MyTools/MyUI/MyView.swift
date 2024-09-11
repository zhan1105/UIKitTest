//
//  MyView.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/11.
//

import UIKit

class MyView: UIView {

    init(addSubview: UIView){
        super.init(frame: .zero)
        setupUI(addSubview: addSubview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(addSubview: UIView){
        self.addSubview(addSubview)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
