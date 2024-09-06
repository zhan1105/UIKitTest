//
//  View+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/6.
//

import UIKit

extension UIView {
    func padding(to padding: CGFloat = 0,
                 top: CGFloat? = nil, bottom: CGFloat? = nil,
                 left: CGFloat? = nil, right: CGFloat? = nil) {
        
        let topPadding      = top ?? padding
        let bottomPadding   = bottom ?? padding
        let leftPadding     = left ?? padding
        let rightPadding    = right ?? padding
        
        self.layoutMargins = UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
    }
}

extension UIView {
    func paddingAnchor(equalTo view: UIView, padding: CGFloat = 0,
                       equalToTop topView: UIView? = nil,
                       equalToBottom bottomView: UIView? = nil,
                       equalToLeading leadingView: UIView? = nil,
                       equalToTrailing trailingView: UIView? = nil) {
        
        var constraints: [NSLayoutConstraint] = []
        
        if let topView = topView {
            constraints.append(self.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: padding))
        } else {
            constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding))
        }

        if let bottomView = bottomView {
            constraints.append(self.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -padding))
        } else {
            constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding))
        }
        
        if let leadingView = leadingView {
            constraints.append(self.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: padding))
        } else {
            constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding))
        }
        
        if let trailingView = trailingView {
            constraints.append(self.trailingAnchor.constraint(equalTo: trailingView.leadingAnchor, constant: -padding))
        } else {
            constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding))
        }

        NSLayoutConstraint.activate(constraints)
    }
}
