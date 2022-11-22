//
//  EmailViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/21.
//

import UIKit
import RxSwift

class EmailViewController: BaseViewController {
    // MARK: - Properties
    private let emailView = EmailView()
    private let emailViewModel = EmailViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = emailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailView.userInputView.textField.becomeFirstResponder()
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        let input = EmailViewModel.Input(email: emailView.userInputView.textField.rx.text)
        let output = emailViewModel.transform(input)
        var isValid = false
        
        output.isValidEmail
            .drive(with: self) { vc, isValidEmail in
                vc.emailView.button.isActivated = isValidEmail
                isValid = isValidEmail
            }
            .disposed(by: disposeBag)
        
        emailView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                if isValid {
                    // 성별 선택 뷰로 넘기기
                    NewUser.shared.email = vc.emailView.userInputView.textField.text!
                } else {
                    vc.showToast(message: String.Email.wrongEmailFormat)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension EmailViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
