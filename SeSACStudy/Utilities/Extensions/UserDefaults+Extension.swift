//
//  UserDefaults+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import Foundation

extension UserDefaults {
    @UserDefault(key: Key.isExistingUser, defaultValue: false)
    static var isExistingUser: Bool
    
    @UserDefault(key: Key.idToken, defaultValue: "")
    static var idToken: String
    
    @UserDefault(key: Key.phoneNumber, defaultValue: "")
    static var phoneNumber: String
    
    @UserDefault(key: Key.isLoggedIn, defaultValue: false)
    static var isLoggedIn: Bool
    
    @UserDefault(key: Key.status, defaultValue: 0)
    static var status: Int
}
