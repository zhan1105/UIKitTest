//
//  LanguageManager.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/27.
//

import Foundation
import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    
    private init() {}
    
    var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "appLanguage")
            updateLanguage()
        }
    }
    
    func setLanguage(_ language: String) {
        UserDefaults.standard.setValue(language, forKey: "temporaryLanguage")
        updateLanguage()
    }
    
    func resetToSystemLanguage() {
        let systemLanguage = Locale.preferredLanguages.first ?? "en"
        print("預設語系：\(systemLanguage)")
        UserDefaults.standard.removeObject(forKey: "temporaryLanguage")
        UserDefaults.standard.setValue(systemLanguage, forKey: "appLanguage")
        updateLanguage()
    }
    
    private func updateLanguage() {
        let languageToUse = UserDefaults.standard.string(forKey: "temporaryLanguage") ?? currentLanguage
        UserDefaults.standard.setValue(languageToUse, forKey: "appLanguage")
        Bundle.swizzleLocalization()
        
        // Notify all observers in the app
        NotificationCenter.default.post(name: .languageChanged, object: nil)
    }
}

private extension Bundle {
    static let swizzleLocalizationImplementation: Void = {
        let originalSelector = #selector(localizedString(forKey:value:table:))
        let swizzledSelector = #selector(swizzled_localizedString(forKey:value:table:))
        
        guard let originalMethod = class_getInstanceMethod(Bundle.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(Bundle.self, swizzledSelector) else {
            return
        }
        
        let didAddMethod = class_addMethod(Bundle.self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(Bundle.self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
    
    static func swizzleLocalization() {
        _ = self.swizzleLocalizationImplementation
    }
    
    @objc func swizzled_localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let languageCode = UserDefaults.standard.string(forKey: "appLanguage"),
              let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: bundlePath) else {
            return self.swizzled_localizedString(forKey: key, value: value, table: tableName)
        }
        
        return bundle.swizzled_localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Notification.Name {
    static let languageChanged = Notification.Name("languageChanged")
}
