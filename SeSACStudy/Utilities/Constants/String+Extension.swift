//
//  String+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import Foundation

extension String {
    enum NetworkError {
        static let networkError = "네트워크 연결 에러"
        static let networkErrorMessage = "네트워크 연결이 원활하지 않습니다.\n연결 상태를 확인하고 다시 시도해 주세요."
    }
    
    enum Action {
        static let ok = "확인"
        static let next = "다음"
    }
    
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
        static let verificationCodePlaceholder = "인증번호 입력"
        static let verifyAndStart = "인증하고 시작하기"
        static let verificationCodeSentToastMessage = "인증번호를 보냈습니다."
        static let wrongCodeFormat = "잘못된 인증번호 형식입니다."  // 기획서 X
        static let verificationFailed = "전화 번호 인증 실패"
        static let idTokenError = "에러가 발생했습니다. 잠시 후 다시 시도해 주세요."
    }
    
    enum Nickname {
        static let inputNickname = "닉네임을 입력해 주세요"
        static let nicknamePlaceholder = "10자 이내로 입력"
        static let nicknameLength = "닉네임은 1자 이상 10자 이내로 부탁드려요."
        static let unavailableNickname = "해당 닉네임은 사용할 수 없습니다."
    }
    
    enum BirthDate {
        static let inputBirthDate = "생년월일을 알려 주세요"
        static let year = "년"
        static let month = "월"
        static let day = "일"
        static let underage = "새싹스터디는 만 17세 이상만 사용할 수 있습니다."
    }
    
    enum Email {
        static let inputEmail = "이메일을 입력해 주세요"
        static let detailedExplanation = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        static let emailPlaceholder = "SeSAC@email.com"
        static let wrongEmailFormat = "이메일 형식이 올바르지 않습니다."
    }
    
    enum Gender {
        static let selectGender = "성별을 선택해 주세요"
        static let detailedExplanation = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        static let male = "남자"
        static let female = "여자"
        static let signUpSucceeded = "회원가입에 성공했습니다./n홈 화면으로 이동합니다."
        static let existingUser = "이미 가입된 유저입니다./n홈 화면으로 이동합니다"
    }
    
    enum Home {
        static let home = "홈"
    }
    
    enum Shop {
        static let sesacShop = "새싹샵"
    }
    
    enum Chats {
        static let friends = "새싹친구"
    }
    
    enum MyInfo {
        static let myInfo = "내 정보"
        static let workInProgress = "준비중입니다."
        
        enum InfoManagement {
            static let infoManagement = "정보 관리"
            static let gender = "내 성별"
            static let study = "자주 하는 스터디"
            static let inputStudy = "스터디를 입력해 주세요"
            static let searchPermission = "내 번호 검색 허용"
            static let ageRange = "상대방 연령대"
            static let deleteAccount = "회원 탈퇴"
        }
    }
}
