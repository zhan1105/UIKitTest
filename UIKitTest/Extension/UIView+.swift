//
//  UIView+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/27.
//

import UIKit

extension UIView {
    
    func mySpacer() -> UIView {
        let newView = UIView()
        newView.backgroundColor = .clear
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        return newView
    }
}
