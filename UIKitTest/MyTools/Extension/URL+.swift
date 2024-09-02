//
//  URL+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

extension URL: ExpressibleByStringLiteral{
    public init(stringLiteral value: StringLiteralType) {
        self.init(string: value.description)!
    }
}
