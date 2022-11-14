//
//  String+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import Foundation

extension String {
    enum Onboarding {
        static let start = "시작하기"
        static let first = "위치 기반으로 빠르게\n주위 친구를 확인"
        static let firstHighlight = "위치 기반"
        static let second = "스터디를 원하는 친구를\n찾을 수 있어요"
        static let secondHighlight = "스터디를 원하는 친구"
        static let third = "SeSAC Study"
    }
    
    enum Verification {
        static let inputPhoneNumber = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        static let phoneNumberPlaceholder = "휴대폰 번호(-없이 숫자만 입력)"
        static let verify = "인증 문자 받기"
        static let startVerification = "전화 번호 인증 시작"
        static let wrongNumberFormat = "잘못된 전화번호 형식입니다."
        static let tooManyRequests = "과도한 인증 시도가 있었습니다.\n나중에 다시 시도해 주세요."
        static let otherErrors = "에러가 발생했습니다.\n다시 시도해주세요"
    }
    
    enum LogIn {
        static let verificationCodeSent = "인증번호가 문자로 전송되었어요"
        static let resend = "재전송"
        static let inputVerificationCode = "인증번호 입력"
        static let verifyAndStart = "인증하고 시작하기"
        static let verificationCodeSentToastMessage = "인증번호를 보냈습니다."
        static let wrongCodeFormat = "잘못된 인증번호 형식입니다."  // 기획서 X
        static let verificationFailed = "전화 번호 인증 실패"
        static let idTokenError = "에러가 발생했습니다. 잠시 후 다시 시도해 주세요."
    }
    
    enum NetworkError {
        static let networkError = "네트워크 연결 에러"
        static let networkErrorMessage = "네트워크 연결이 원활하지 않습니다.\n연결 상태를 확인하고 다시 시도해 주세요."
    }
    
    static let ok = "확인"
}
