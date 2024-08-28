//
//  UIFont+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/12.
//

import UIKit

extension UIFont {
    
    static let largeTitle = UIFont.preferredFont(forTextStyle: .largeTitle)
    static let title1 = UIFont.preferredFont(forTextStyle: .title1)
    static let title2 = UIFont.preferredFont(forTextStyle: .title2)
    static let title3 = UIFont.preferredFont(forTextStyle: .title3)
    
    static let boldTitle1 = UIFont.systemFont(ofSize: UIFont.title1.pointSize, weight: .bold)
    static let boldTitle2 = UIFont.systemFont(ofSize: UIFont.title2.pointSize, weight: .bold)
}
