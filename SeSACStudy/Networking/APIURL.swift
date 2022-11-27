//
//  Endpoint.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import Foundation

struct APIURL {
    private init() { }
    
    static let baseURL = "http://api.sesac.co.kr:1210"
    
    enum v1: String {
//        static let user = "/v1/user"
//        static let withdraw = "/v1/user/withdraw"
//        static let updateFCMToken = "/v1/user/update_fcm_token"
//        static let myPage = "/v1/user/mypage"
        
        case logIn
        case signUp
        case withdraw
        case updateFCMToken
        case myPage
        
        var endpoint: String {
            let version = "/v1/user"
            switch self {
                case .logIn, .signUp:
                    return version
                default:
                    return version + "/" + self.rawValue
            }
//            return version + self.rawValue
        }
    }
}
