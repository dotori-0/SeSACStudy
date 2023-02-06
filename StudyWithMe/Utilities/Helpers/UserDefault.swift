//
//  UserDefault.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let container: UserDefaults = .standard
    
    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
