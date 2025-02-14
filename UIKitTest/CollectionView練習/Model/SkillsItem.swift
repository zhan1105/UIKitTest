//
//  SkillsItem.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/14.
//

import UIKit
import Foundation

typealias Skills = (title: String, icon: UIImage)

struct SkillsItem {
    
    let skillData: [Skills] = [("Swift", .swift), ("SwiftUI", .swiftui), ("Objective-C", .objectiveC), ("Android Studio", .androidStudio)]
}
