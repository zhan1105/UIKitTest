//
//  LanguageManager.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/27.
//

import Foundation

class LanguageManager {
    static let shared = LanguageManager()
    
    private init() {}
    
    var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "appLanguage")
            // No need to call synchronize here
            updateLanguage()
        }
    }
    
    func setLanguage(_ language: String) {
        currentLanguage = language
    }
    
    private func updateLanguage() {
        Bundle.swizzleLocalization()
    }
}

private extension Bundle {
    
    private static let swizzleLocalizationImplementation: Void = {
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
