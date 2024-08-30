//
//  SFSymbol.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/14.
//

import UIKit
import Foundation

enum SFSymbol: String {
    case arrow_left         = "arrowtriangle.left.fill"
    case arrow_right        = "arrowtriangle.right.fill"
    case bell_not           = "bell"
    case bell               = "bell.badge"
    case ellipsis           = "ellipsis.circle"
}

extension UIImage {
    convenience init?(systemSymbol: SFSymbol) {
        self.init(systemName: systemSymbol.rawValue)
    }
}

extension UIButton {
    func setSymbolImage(_ symbol: SFSymbol, for state: UIControl.State) {
        self.setImage(UIImage(systemSymbol: symbol), for: state)
    }
}
