//
//  UserDefaultsKey.swift
//  transfer
//
//  Created by 紹郁 on 2024/9/16.
//

import Foundation

enum UserDefaultsKey: String {
    case isFirstOpen
}

extension UserDefaults {
    
    func bool(forKey key: UserDefaultsKey) -> Bool {
        return bool(forKey: key.rawValue)
    }

    func set(_ value: Bool, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }

    func string(forKey key: UserDefaultsKey) -> String? {
        return string(forKey: key.rawValue)
    }

    func set(_ value: String?, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }
    
    func int(forKey key: UserDefaultsKey) -> Int? {
        return integer(forKey: key.rawValue)
    }

    func set(_ value: Int?, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }
    
    func float(forKey key: UserDefaultsKey) -> Float? {
        return float(forKey: key.rawValue)
    }

    func set(_ value: Float?, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }
    
    func double(forKey key: UserDefaultsKey) -> Double? {
        return double(forKey: key.rawValue)
    }

    func set(_ value: Double?, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }

    func remove(forKey key: UserDefaultsKey) {
        removeObject(forKey: key.rawValue)
    }
}
