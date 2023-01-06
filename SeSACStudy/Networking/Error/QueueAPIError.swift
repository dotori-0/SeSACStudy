//
//  QueueAPIError.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/05.
//

import Foundation

/// fetchNearbyUsers, myQueueState, rate
enum QueueAPIError: Int, Error {
    case success = 200
    case firebaseTokenError = 401
    case unregisteredUser = 406
    case serverError = 500
    case clientError = 501
    
    enum MyQueueState: Int, Error {
        case defaultState = 201
    }
}

extension QueueAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .success:
                return "성공"
            case .firebaseTokenError:
                return "Firebase Token Error"
            case .unregisteredUser:
                return "미가입 유저"
            case .serverError:
                return "서버 에러가 발생했습니다.\n"
            case .clientError:
                return "Client Error"
        }
    }
}
