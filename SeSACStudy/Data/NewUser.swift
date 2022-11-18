//
//  NewUser.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/19.
//

import Foundation

final class NewUser {
    private init() { }
    
    static let shared = NewUser()
    
    var phoneNumber = ""
    var FCMToken = ""
    var nickname = ""
    var birthDate = ""
    var email = ""
    var gender = 0
}
