//
//  UserDefaultsKey+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import Foundation

extension UserDefaults {
    enum Key {
        static let isExistingUser = "isExistingUser"
        static let idToken = "idToken"
    }
    
    static func delete(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func remove(_ key: UserDefault<String>) {
        UserDefaults.standard.removeObject(forKey: key.key)
    }
}
