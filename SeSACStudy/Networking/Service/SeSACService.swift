//
//  SeSACService.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import Foundation
import Moya

enum SeSACService {
    case logIn
    case signUp(phoneNumber: String, FCMToken: String, nickname: String, birthDate: String, email: String, gender: Int)
    case withdraw
    case updateFCMToken(FCMToken: String)
    case myPage(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, study: String?)
}

extension SeSACService: TargetType {
    var baseURL: URL {
        return URL(string: APIURL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .logIn:
                return APIURL.v1.logIn.endpoint
            case.signUp:
                return APIURL.v1.signUp.endpoint
            case .withdraw:
                return APIURL.v1.withdraw.endpoint
            case .updateFCMToken:
                return APIURL.v1.updateFCMToken.endpoint
            case .myPage:
                return APIURL.v1.myPage.endpoint
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .logIn:
                return .get
            case .signUp:
                return .post
            case .withdraw:
                return .post
            case .updateFCMToken:
                return .put
            case .myPage:
                return .put
        }
    }
    
    var headers: [String: String]? {
        return ["idtoken": UserDefaults.idToken,
                "Content-Type": "application/x-www-form-urlencoded"]
//        return ["idtoken": UserDefaults.idToken]
      }
    
    var task: Moya.Task {
        switch self {
            case .logIn:
                return .requestPlain
            case .signUp(let phoneNumber, let FCMToken, let nickname, let birthDate, let email, let gender):
                
                print("🥲 idToken: \(UserDefaults.idToken)")
                print("🥲 전화번호: \(phoneNumber)")
                print("🥲 FCMToken: \(FCMToken)")
                print("🥲 닉네임: \(nickname)")
                print("🥲 생년월일: \(birthDate)")
                print("🥲 이메일: \(email)")
                print("🥲 성별: \(gender)")
                
                let parameters: [String: Any] = ["phoneNumber": phoneNumber,
                                                 "FCMtoken": FCMToken,
                                                 "nick": nickname,
                                                 "birth": birthDate,
                                                 "email": email,
                                                 "gender": gender]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)  // URLEncoding.queryString 시 501 에러
            case .withdraw:
                return .requestPlain
            case .updateFCMToken(let FCMToken):
                let parameter: [String: Any] = ["FCMtoken": FCMToken]
                return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
            case .myPage(let searchable, let ageMin, let ageMax, let gender, let study):
                let parameters: [String: Any] = ["searchable": searchable,
                                                 "ageMin": ageMin,
                                                 "ageMax": ageMax,
                                                 "gender": gender,
                                                 "study": study]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var validationType: ValidationType {
        switch self {
            case .signUp:
                return .customCodes([200])
            default: return .successCodes
        }
    }
}
