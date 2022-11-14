//
//  LogInViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

class LogInViewController: BaseViewController {
    // MARK: - Properties
    var verificationID = ""
    private let logInView = LogInView()
    private let logInViewModel = LogInViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = logInView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        showToast(message: String.LogIn.verificationCodeSentToastMessage)
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        let input = LogInViewModel.Input(verificationCode: logInView.userInputView.textField.rx.text)
        let output = logInViewModel.transform(input)
        var isValid = false
        
        // drive 구현 방법 1
        output.limitedCode
            .drive(logInView.userInputView.textField.rx.text)
            .disposed(by: disposeBag)
        
        // drive 구현 방법 2
        output.isValidCode
            .drive(with: self, onNext: { vc, isValidCode in
                vc.logInView.button.isActivated = isValidCode
                isValid = isValidCode
            })
            .disposed(by: disposeBag)
        
        // drive 구현 방법 3
        logInView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                if isValid {
                    vc.logIn(verificationCode: vc.logInView.userInputView.textField.text!)
                } else {
                    vc.showToast(message: String.LogIn.wrongCodeFormat)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    private func logIn(verificationCode: String) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                print("❌", error)
                print("❌", error.localizedDescription)
                
                let authError = error as NSError
                if (authError.code == AuthErrorCode.userTokenExpired.rawValue) ||
                    (authError.code == AuthErrorCode.invalidVerificationCode.rawValue) {
                    self?.showToast(message: String.LogIn.verificationFailed)
                }
            } else {
                print("⭕️ 성공", authResult.debugDescription)
            }
            print("❎", error.debugDescription)
            
            
            let currentUser = Auth.auth().currentUser
            // objective-c 메서드인 것 같은데... ❔
            currentUser?.getIDTokenForcingRefresh(true) { [weak self] idToken, error in
                if let error = error {
                    print(error)
                    self?.showToast(message: String.LogIn.idTokenError)
                    return
                } else if let idToken {
                    print("🪙 \(idToken)")
                    UserDefaults.idToken = idToken
                }
                
                
                
                // 서버로부터 사용자 정보 확인 후 기존/신규 사용자 분기처리
            }
            
//            currentUser?.getIDTokenResult(forcingRefresh: true) { authTokenResult, error in
//                authTokenResult?.token
//            }
        }
    }
}
