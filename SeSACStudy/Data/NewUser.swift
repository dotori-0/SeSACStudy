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
    
    var phoneNumber = UserDefaults.phoneNumber
    var FCMToken = "dzjnejNDh0d0u1aLzfS547:APA91bFvQSjDVFC4-2IA0QQ08KqsEKwIoK2hFBZIfdyNLPd22PvgLD6YM_kyQgv0BIK-1zjltbbKYQTGK50Pn21bctsuEC46qo7RDkcImbzyZBe0-ffMqhFhL4DO5tbP0Ri_Wn-vRVF5"
    var nickname = ""
    var birthDate = ""
    var email = ""
    var gender = 0
}
