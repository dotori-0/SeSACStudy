//
//  LogInViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import UIKit

import RxCocoa
import RxSwift

class LogInViewController: BaseViewController {
    // MARK: - Properties
    private let logInView = LogInView()
    private let logInViewModel = LogInViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = logInView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        let input = LogInViewModel.Input(verificationCode: logInView.userInputView.textField.rx.text)
        let output = logInViewModel.transform(input)
        
        // drive 구현 방법 1
        output.limitedCode
            .drive(logInView.userInputView.textField.rx.text)
            .disposed(by: disposeBag)
        
        // drive 구현 방법 2
        output.isValidCode
            .drive(with: self, onNext: { vc, isValid in
                vc.logInView.button.isActivated = isValid
            })
//            .drive(onNext: { isValid in
//                logInView.button.isActivated = isValid
//            })
//            .drive(logInView.button.isActivated)
            .disposed(by: disposeBag)
    }
}
