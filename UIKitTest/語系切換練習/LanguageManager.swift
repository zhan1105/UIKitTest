//
//  LanguageManager.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//
import UIKit

class LanguageManager {
    static let shared = LanguageManager()

    func setLanguage(_ language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

        print("Current Language: \(UserDefaults.standard.array(forKey: "AppleLanguages") ?? [])")

        // 获取当前的 scene delegate
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }

        // 重新加载 rootViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
