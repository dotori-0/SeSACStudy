//
//  VerificationViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

final class VerificationViewController: BaseViewController {
    // MARK: - Properties
    private let verificationView = VerificationView()
    private let verificationViewModel = VerificationViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = verificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
//        bindTextFieldWithCALayer()  // CALayer
        
        verificationView.userInputView.textField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
//        verificationView.phoneNumberTextField.setBottomLine()  // CALayer
    }
    
    // MARK: - Setting Methods
    private func setNavigationBar() {
        print(self, "navigationController: \(navigationController)")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.scrollEdgeAppearance = nil
        // navigationItem로 접근하면 기존의 appearance가 바뀌지 않음
//        navigationItem.scrollEdgeAppearance = nil
//        UINavigationBar.appearance().scrollEdgeAppearance = nil  // 안되는 이유? ❔
        

//        navigationItem.backBarButtonItem = backBarButtonItem  // 다음 VC에서 black backBarButtonItem이 나오지만, < 가 같이 나옴
//        navigationItem.leftBarButtonItem = backBarButtonItem  // 현재 VC에서 backBarButtonItem이 나오고, 다음 VC에서는 기존 < Back이 나옴
    }
    
    // MARK: - Binding
    private func bind() {
//        let input = VerificationViewModel.Input(editingDidBegin: verificationView.userInputView.textField.rx.controlEvent([.editingDidBegin]),
//                                                editingDidEnd: verificationView.userInputView.textField.rx.controlEvent([.editingDidEnd]),
        let input = VerificationViewModel.Input(phoneNumber: verificationView.userInputView.textField.rx.text,
                                                verifyButtonTap: verificationView.button.rx.tap)
        
        let output = verificationViewModel.transform(input)
        var isValid = false
        
        // 입력 상태에 따라 TextField의 bottomLine 컬러 바꾸기
//        output.editingDidBegin
//            .drive(with: self) { vc, _ in
//                vc.verificationView.userInputView.isTextFieldFocused = true  // UIView
//            }
//            .disposed(by: disposeBag)
//
//        output.editingDidEnd
//            .drive(with: self) { vc, _ in
//                vc.verificationView.userInputView.isTextFieldFocused = false  // UIView
//            }
//            .disposed(by: disposeBag)
        
        // 입력한 번호의 유효성에 따라 버튼 컬러 바꾸기
        output.isValidNumber
        //            .bind(to: verificationView.verifyButton.rx.isActivated)  // rx 객체라면 self가 필요하지 않지만 일반 객체라면 withUnretained(self) 나 [weak self]를 통해 self의 객체로 접근헤야 하는 것..? ❔
            .withUnretained(self)
            .bind(onNext: { (vc, isValidNumber) in
                vc.verificationView.button.isActivated = isValidNumber
                isValid = isValidNumber
            })
            .disposed(by: disposeBag)
        
        output.number
            .drive(verificationView.userInputView.textField.rx.text)
            .disposed(by: disposeBag)

        output.verifyButtonTap
            .withUnretained(self)
            .bind { (vc, _) in
                
//                let isValid = BehaviorRelay(value: false)
//                output.isValidNumber.bind(to: isValid).disposed(by: vc.disposeBag)
                
                let output2 = vc.verificationViewModel.transform(input)  // 다시 바꿔야만 텍스트필드 텍스트에 국가번호 붙은 걸 사용할 수 있는 이유는.. 그냥 output2.prefixedNumber이 rx 객체가 아니라 String 이라서..?❔
                
                if isValid {
                    vc.showToast(message: String.Verification.startVerification, duration: 2.0)
//                    vc.verifyPhoneNumber(output.prefixedNumber)  // 국가번호를 붙인 번호
                    vc.verifyPhoneNumber(output2.prefixedNumber)  // 국가번호를 붙인 번호
//                    vc.verifyFictionalPhoneNumber()  // Firebase 가상번호 테스트
//                    vc.verifyPhoneNumberWithPush()   // 실제 가상번호 테스트
                } else {
                    vc.showToast(message: String.Verification.wrongNumberFormat)
                }
            }
            .disposed(by: disposeBag)
        
        
        

        
        
//        verificationView.phoneNumberInputView.textField.rx.controlEvent([.editingDidBegin])
//            .asDriver()
//            .drive(with: self) { vc, _ in
//                vc.verificationView.phoneNumberInputView.isTextFieldFocused = true  // UIView
//            }
//            .disposed(by: disposeBag)
//
//        verificationView.phoneNumberInputView.textField.rx.controlEvent([.editingDidEnd])
//            .asDriver()
//            .drive(with: self) { vc, _ in
//                vc.verificationView.phoneNumberInputView.isTextFieldFocused = false  // UIView
//            }
//            .disposed(by: disposeBag)
    }
    
//    private func bindTextFieldWithCALayer() {
//        verificationView.phoneNumberTextField.rx.controlEvent([.editingDidBegin])
//            .asDriver()
//            .drive(with: self) { vc, _ in
//                vc.verificationView.phoneNumberTextField.changeBottomLineColorToFocus()  // CALayer
//            }
//            .disposed(by: disposeBag)
//
//        verificationView.phoneNumberTextField.rx.controlEvent([.editingDidEnd])
//            .asDriver()
//            .drive(with: self) { vc, _ in
//                vc.verificationView.phoneNumberTextField.changeBottomLineColorToFocus()  // CALayer
//            }
//            .disposed(by: disposeBag)
//    }
}

extension VerificationViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension VerificationViewController {
    private func verifyPhoneNumber(_ prefixedNumber: String) {
//        let number = "+447893920177"
//        let number = "+447893920172"
//        let number = "+15412071596"
//        let number = "+447893920175"  // 막으신듯?
//        let number = "+447893920162"
//        let number = "+447893920174"  // 막힘
        let number = "+67074253187"
        print("🇰🇷 국가번호 장착번호: \(prefixedNumber)")
        
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(prefixedNumber, uiDelegate: nil) { [weak self] verificationID, error in
              
              if let error = error {
                  print(error)
                  let authError = error as NSError
                  print(authError)
                  if authError.code == AuthErrorCode.tooManyRequests.rawValue {
                      self?.showToast(message: String.Verification.tooManyRequests)
                  } else {
                      self?.showToast(message: String.Verification.otherErrors)
                  }
                  return
              }
              
              guard let verificationID else { return }
              print("🆔 \(verificationID)")
              
//              NewUser.shared.phoneNumber = prefixedNumber
              UserDefaults.phoneNumber = prefixedNumber
              
              let logInVC = LogInViewController()
              logInVC.verificationID = verificationID
              
              self?.transition(to: logInVC)
          }
    }
    
    // Firebase 가상 번호
    private func verifyFictionalPhoneNumber() {
//        let phoneNumber = "+16505554567"
        let phoneNumber = "+821011112222"

        // This test verification code is specified for the given test phone number in the developer console.
        let testVerificationCode = "121212"

        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate:nil) {
                                                                    verificationID, error in
            if ((error) != nil) {
              // Handles error
//              self.handleError(error)
                print(error)
              return
            }
            
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "",
                                                                       verificationCode: testVerificationCode)
//            Auth.auth().signInAndRetrieveData(with: credential) { authData, error in
            Auth.auth().signIn(with: credential) { authData, error in
                if ((error) != nil) {
                // Handles error
//                self.handleError(error)
                print(error)
                return
              }

                print("☺️ \(authData?.user)")
            }
        }
    }
    
//    private func verifyPhoneNumberWithPush() {
//        let phoneNumber = "+447893920172"
//
//        // This test verification code is specified for the given test phone number in the developer console.
//        let testVerificationCode = "121212"
//
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
//        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate:nil) { [weak self] verificationID, error in
//            print("🆔 \(verificationID)")
//
//            if let error = error {
//                print(error)
//                let authError = error as NSError
//                print(authError)
//                if authError.code == AuthErrorCode.tooManyRequests.rawValue {
//                    self?.showToast(message: String.Verification.tooManyRequests)
//                } else {
//                    self?.showToast(message: String.Verification.otherErrors)
//                }
//                return
//            }
//
//            self?.showToast(message: String.Verification.startVerification)
//        }
//    }
}
