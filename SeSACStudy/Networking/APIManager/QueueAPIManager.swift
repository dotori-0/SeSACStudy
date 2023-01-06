//
//  QueueAPIManager.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/05.
//

import Foundation
import Moya

struct QueueAPIManager {
    private init() { }
    
    private static let provider = MoyaProvider<Queue>()
    
    static func myQueueState(completion: @escaping (Result<MyQueueState, Error>) -> Void) {
        provider.request(.myQueueState) { result in
            do {
                let response = try result.get()
                let myQueueState = try response.map(MyQueueState.self)
                completion(.success(myQueueState))
            } catch {
                guard let definedError = definedError(error) else {
                    print("🤨 처음 보는 status code")
                    return
                }
                print("🙎🏻‍♀️ 지정에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
    
    static func fetchNearbyUsers(latitude: Double, longitude: Double,
                                 completion: @escaping (Result<QueueDB, Error>) -> Void) {
        provider.request(.fetchNearbyUsers(latitude: latitude,
                                           longitude: longitude)) { result in
            do {
                let response = try result.get()
                let queueDB = try response.map(QueueDB.self)
                completion(.success(queueDB))
            } catch {
                guard let definedError = definedError(error) else {
                    print("🤨 처음 보는 status code")
                    return
                }
                print("🙎🏻‍♀️ 지정에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
}

extension QueueAPIManager {
    private static func definedError(_ error: Error) -> Error? {
        guard let moyaError = error as? MoyaError else {
            print("😣 error -> MoyaError 변경 실패")
            return nil
        }
        
        guard let response = moyaError.response else {
            print("😣 moyaError -> Response 변경 실패")
            return nil
        }
        
        let statusCode = response.statusCode
        print("🐕 QueueAPIManager statusCode: \(statusCode)")
        
        if let definedError = QueueAPIError(rawValue: statusCode) {
            return definedError
        }
        
        let definedError = QueueAPIError.MyQueueState(rawValue: statusCode)
        
        return definedError
    }
}
