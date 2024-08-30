//
//  ViewAnimation+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//
import UIKit
import Foundation

extension UIViewController {
    
    enum TransitionAnimation {
        case crossFading
        case zoomOut
        case depth
        case linear
        case coverFlow
        case cubic
        
        var transitionOptions: UIView.AnimationOptions {
            switch self {
            case .crossFading:
                return .transitionCrossDissolve
            case .zoomOut:
                return .transitionFlipFromTop
            case .depth:
                return .transitionFlipFromBottom
            case .linear:
                return .transitionCurlUp
            case .coverFlow:
                return .transitionCurlDown
            case .cubic:
                return .transitionFlipFromLeft
            }
        }
    }
}

