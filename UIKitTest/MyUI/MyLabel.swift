//
//  MyLabel.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit

class MyLabel: UILabel {

    init(text: String = "Label") {
        super.init(frame: .zero)
        setupUI(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(text: String) {
        self.text = text
        self.font = UIFont.boldTitle2
        self.textColor = .black
        self.textAlignment = .center
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
