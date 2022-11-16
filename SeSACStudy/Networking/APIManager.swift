//
//  APIManager.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/15.
//

import Foundation
import Moya

struct APIManager {
    private init() { }
    
    private static let provider = MoyaProvider<SeSACService>()
    
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
}

extension APIManager {
    private static func definedError(_ error: Error) -> SeSACError? {
        guard let moyaError = error as? MoyaError else {
            print("로그인: error -> MoyaError 변경 실패")
            return nil
        }
        
        guard let response = moyaError.response else {
            print("로그인: moyaError -> Response 변경 실패")
            return nil
        }
        
        let statusCode = response.statusCode
        
//        guard let definedError = SeSACError(rawValue: statusCode) else {
//            print("🤨 처음 보는 status code")
//            return nil
//        }
        
        let definedError = SeSACError(rawValue: statusCode)
        
        return definedError
    }
}
