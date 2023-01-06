//
//  APIManager.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/15.
//

import Foundation
import Moya

struct UserAPIManager {
    private init() { }
    
    private static let provider = MoyaProvider<UserAPI>()
    
    static func logIn(completion: @escaping (Result<User, Error>) -> Void) {
        provider.request(.logIn) { result in
            do {
                let response = try result.get()
//                response.filterSuccessfulStatusCodes()
                let user = try response.map(User.self)
                print("👤 유저: \(user)")
                completion(.success(user))
            } catch {
//                error.asAFError?.responseCode
//                (error as MoyaError).response?.statusCode
                guard let definedError = definedError(error) else {
                    print("🤨 처음 보는 status code")
                    return
                }
                
                print("🙎🏻‍♀️ 에러: \(definedError)")
                completion(.failure(definedError))
            }
            
//            switch result {
//                case .success(_):
//                    <#code#>
//                case .failure(_):
//                    <#code#>
//            }
        }
    }
    
    static func signUp(completion: @escaping (Result<Void, Error>) -> Void) {
        print(#function, "START")
        provider.request(.signUp(phoneNumber: NewUser.shared.phoneNumber,
                                 FCMToken: NewUser.shared.FCMToken,
                                 nickname: NewUser.shared.nickname,
                                 birthDate: NewUser.shared.birthDate,
                                 email: NewUser.shared.email,
                                 gender: NewUser.shared.gender)) { result in
            
            print("🆙 전화번호: \(NewUser.shared.phoneNumber)")
            print("🆙 FCMToken: \(NewUser.shared.FCMToken)")
            print("🆙 닉네임: \(NewUser.shared.nickname)")
            print("🆙 생년월일: \(NewUser.shared.birthDate)")
            print("🆙 이메일: \(NewUser.shared.email)")
            print("🆙 성별: \(NewUser.shared.gender)")
            
            switch result {
                case .success(let response):
                    print("가입 response: \(response)")
                    let statusCode = response.statusCode
                    print("가입 statusCode: \(statusCode)")
                    completion(.success(()))
                case .failure(let error):
                    guard let definedError = definedError(error) else {
                        print("🤨 처음 보는 status code")
                        return
                    }
                    
                    print("🙎🏻‍♀️ 에러: \(definedError)")
                    completion(.failure(definedError))
            }
            
            print(#function, "END")
            
            return
            
            do {
                let response = try result.get()
                print("가입 response: \(response)")
                let statusCode = response.statusCode
                print("가입 statusCode: \(statusCode)")
                completion(.success(()))
                
//                if statusCode == 200 {
//                    print("statusCode == 200")
//                    completion(.success(()))
//                } else {
//                    guard let definedError = SeSACError(rawValue: statusCode) else {
//                        print("🤨 처음 보는 status code")
//                        return
//                    }
//                    throw definedError
//                }
            } catch {
                print("가입 catch")
                print("🙎🏻‍♀️ 에러: \(error)")
                guard let definedError = definedError(error) else {
                    print("🤨 처음 보는 status code")
                    return
                }
                print("🙎🏻‍♀️ 지정에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
    
    static func withdraw(completion: @escaping (Result<Void, UserAPIError>) -> Void) {
        provider.request(.withdraw) { result in
            switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    guard let definedError = definedError(error) else {
                        print("🤨 처음 보는 status code")
                        return
                    }
                    
                    print("🙎🏻‍♀️ 에러: \(definedError)")
                    completion(.failure(definedError))
            }
        }
    }
}

extension UserAPIManager {
    private static func definedError(_ error: Error) -> UserAPIError? {
        guard let moyaError = error as? MoyaError else {
            print("😣 error -> MoyaError 변경 실패")
            return nil
        }
        
        guard let response = moyaError.response else {
            print("😣 moyaError -> Response 변경 실패")
            return nil
        }
        
        let statusCode = response.statusCode
        
//        guard let definedError = SeSACError(rawValue: statusCode) else {
//            print("🤨 처음 보는 status code")
//            return nil
//        }
        
        let definedError = UserAPIError(rawValue: statusCode)
        
        return definedError
    }
}
