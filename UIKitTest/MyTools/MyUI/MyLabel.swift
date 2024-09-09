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
    
    private var textPadding: UIEdgeInsets = .zero
    
    // 添加 padding 方法
    func padding(to padding: CGFloat = 0,
                 top: CGFloat? = nil, bottom: CGFloat? = nil,
                 left: CGFloat? = nil, right: CGFloat? = nil) {
        
        let topPadding      = top ?? padding
        let bottomPadding   = bottom ?? padding
        let leftPadding     = left ?? padding
        let rightPadding    = right ?? padding
        
        textPadding = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
        
        setNeedsDisplay()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textPadding))
    }
}

