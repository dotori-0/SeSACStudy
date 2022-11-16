//
//  SeSACError.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/15.
//

import Foundation

enum SeSACError: Int, Error {
    case success = 200
    case existingUser = 201         // 회원가입
    case unavailableNickname = 202  // 회원가입
    case firebaseTokenError = 401
    case unregisteredUser = 406     // 로그인, 마이페이지, 탈퇴, FCM 토큰 갱신 (회원가입 제외하고 전부)
    case serverError = 500
    case clientError = 501
}

extension SeSACError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .success:
                return "성공"
            case .existingUser:
                return "이미 가입한 유저"
            case .unavailableNickname:
                return "해당 닉네임은 사용할 수 없습니다."
            case .firebaseTokenError:
                return "Firebase Token Error"
            case .unregisteredUser:
                return "미가입 유저"
            case .serverError:
                return "Server Error"
            case .clientError:
                return "Client Error"
        }
    }
}
