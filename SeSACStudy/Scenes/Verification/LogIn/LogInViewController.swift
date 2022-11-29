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
        
        setNavigationBar()
//        fetchIDToken()
        showToast(message: String.LogIn.verificationCodeSentToastMessage)
        bind()
    }
    
    // MARK: - Setting Methods
    private func setNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = AppAppearance.navigationBarAppearance
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
//                    vc.transition(to: TabBarController())
                    
                    vc.signInToFirebase(verificationCode: vc.logInView.userInputView.textField.text!)  // for service
                    
                    // for test
//                    vc.refreshIDToken {
//                        vc.logInAndPush()
//                    }
                } else {
                    vc.showToast(message: String.LogIn.wrongCodeFormat)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    private func signInToFirebase(verificationCode: String) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                print("❌", error)
                print("❌", error.localizedDescription)
                
                let authError = error as NSError

                // 유효 기간 만료 혹은 인증 번호 불일치 시 '전화 번호 인증 실패' toast
                if (authError.code == AuthErrorCode.sessionExpired.rawValue) ||
                    (authError.code == AuthErrorCode.invalidVerificationCode.rawValue) {
                    self?.showToast(message: String.LogIn.verificationFailed)
                }
            } else {
                print("⭕️ 성공", authResult.debugDescription)
                self?.refreshIDToken {
                    self?.logInAndPush()
                }
            }
            print("❎", error.debugDescription)
            
//            authResult?.user.getIDTokenForcingRefresh(<#T##forceRefresh: Bool##Bool#>)
//            self?.fetchIDToken()
            
//            currentUser?.getIDTokenResult(forcingRefresh: true) { authTokenResult, error in
//                authTokenResult?.token
//            }
        }
    }
    
    private func logInAndPush() {
        logInViewModel.logIn()
        
        logInViewModel.user
//            .withUnretained(self)
            .subscribe(with: self) { vc, user in  // onError에서도 vc 쓰기 위해서는 with: self로 해야 하는 것이 맞는지?❔
                print(user)
                // 홈화면으로 이동
//                vc.transition(to: TabBarController())
                vc.setRootVCToTabBarController()
            } onError: { vc, error in
                print("🥚 logInViewModel onError")
                print("🥚", error.localizedDescription)
                // 에러인데 200이 나오면 이상한거..인듯?
                // 401 파베토큰 에러가 나오면 fetchIDToken 다시 실행?
                guard let error = error as? SeSACError else {
                    print("SeSACError로 변환 실패")
                    return
                }
                
                switch error {
                    case .firebaseTokenError:
                        // fetchIDToken 다시 실행?👻
                        vc.refreshIDToken {
                            vc.logInAndPush()
                        }
                        print("firebaseTokenError")
                    case .unregisteredUser:
                        print("unregisteredUser")
                        vc.transition(to: NicknameViewController())
                    default:
                        print("default")
                }
            }
            .disposed(by: disposeBag)
    }
}
