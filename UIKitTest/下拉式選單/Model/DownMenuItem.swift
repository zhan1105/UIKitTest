//
//  DownMenuItem.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit
import Foundation

typealias Menu = (name: String, image: UIImage)

struct DownMenuItem {
    
    let menuData: [Menu] = [("Swift",           .swift),
                            ("SwiftUI",         .swiftui),
                            ("Objective-C",     .objectiveC),
                            ("Android Studio",  .androidStudio)]
}
