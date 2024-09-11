//
//  View+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/6.
//

import UIKit

extension UIView {
    func paddingAnchor(equalTo view: UIView, padding: CGFloat = 0,
                       top: CGFloat? = nil, bottom: CGFloat? = nil,
                       left: CGFloat? = nil, right: CGFloat? = nil,
                       equalToTop topView: UIView? = nil,
                       equalToBottom bottomView: UIView? = nil,
                       equalToLeading leadingView: UIView? = nil,
                       equalToTrailing trailingView: UIView? = nil) {
        
        let topPadding      = top ?? padding
        let bottomPadding   = bottom ?? padding
        let leftPadding     = left ?? padding
        let rightPadding    = right ?? padding
        
        var constraints: [NSLayoutConstraint] = []
        
        if let topView = topView {
            constraints.append(self.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: topPadding))
        } else {
            constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding))
        }

        if let bottomView = bottomView {
            constraints.append(self.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -bottomPadding))
        } else {
            constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding))
        }
        
        if let leadingView = leadingView {
            constraints.append(self.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: leftPadding))
        } else {
            constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPadding))
        }
        
        if let trailingView = trailingView {
            constraints.append(self.trailingAnchor.constraint(equalTo: trailingView.leadingAnchor, constant: -rightPadding))
        } else {
            constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightPadding))
        }

        NSLayoutConstraint.activate(constraints)
    }
}
