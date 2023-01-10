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
    
    /// 새싹 찾기 요청
    static func find(latitude: Double, longitude: Double, studyList: [String],
                     completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.find(latitude: latitude, longitude: longitude, studyList: studyList)) { result in
            switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    print("새싹 찾기 요청 statusCode: \(statusCode)")
                    completion(.success(()))
                case .failure(let error):
                    guard let definedError = definedError(error, api: .find) else {
                        print("🤨 처음 보는 status code")
                        return
                    }
                    
                    print("🙎🏻‍♀️ 에러: \(definedError)")
                    completion(.failure(definedError))
            }
        }
    }
    
    /// 사용자(본인)의 매칭상태 확인
    static func myQueueState(completion: @escaping (Result<MyQueueState, Error>) -> Void) {
        provider.request(.myQueueState) { result in
            do {
                print("func myQueueState 1")
                let response = try result.get()
                print("func myQueueState 2")
//                print(response)
//                dump(response)
                let myQueueState = try response.map(MyQueueState.self)
                print("func myQueueState 3")
                completion(.success(myQueueState))
            } catch {
                guard let definedError = definedError(error, api: .myQueueState) else {
                    print("🤨 처음 보는 status code")
                    return
                }
                print("🙎🏻‍♀️ 지정에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
    
    /// 주변 새싹 탐색 기능
    static func fetchNearbyUsers(latitude: Double, longitude: Double,
                                 completion: @escaping (Result<QueueDB, Error>) -> Void) {
        provider.request(.fetchNearbyUsers(latitude: latitude,
                                           longitude: longitude)) { result in
            do {
                let response = try result.get()
                let queueDB = try response.map(QueueDB.self)
                completion(.success(queueDB))
            } catch {
                guard let definedError = definedError(error, api: .fetchNearbyUsers) else {
                    print("🤨 처음 보는 status code")
                    return
                }
                print("🙎🏻‍♀️ 지정에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
    
    /// 스터디 요청
    static func requestStudy(otheruid: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.requestStudy(otheruid: otheruid)) { result in
            switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    print("스터디 요청 statusCode: \(statusCode)")
                    completion(.success(()))
                case .failure(let error):
                    guard let definedError = definedError(error, api: .requestStudy) else {
                        print("🤨 처음 보는 status code")
                        return
                    }
                    
                    print("🙎🏻‍♀️ 에러: \(definedError)")
                    completion(.failure(definedError))
            }
        }
    }
}

extension QueueAPIManager {
    /// 커스텀 에러로 변환하는 메서드
    private static func definedError(_ error: Error, api: APIURL.v1Queue) -> Error? {
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
        
        let definedError: Error?
        
        switch api {
            case .find:
                definedError = QueueAPIError.Find(rawValue: statusCode)
//            case .stopFinding:
//                <#code#>
            case .myQueueState:
                definedError = QueueAPIError.MyQueueState(rawValue: statusCode)
            case .requestStudy:
                definedError = QueueAPIError.RequestStudy(rawValue: statusCode)
//            case .acceptStudy:
//                <#code#>
//            case .cancelStudy:
//                <#code#>
            default:
                print("default")  // fetchNearbyUsers, rate
                return nil
        }
        
//        let definedError = QueueAPIError.MyQueueState(rawValue: statusCode)
        
        return definedError
    }
}
