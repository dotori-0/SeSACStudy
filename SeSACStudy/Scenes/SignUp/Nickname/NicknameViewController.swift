//
//  NicknameViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/16.
//

import UIKit
import RxSwift

final class NicknameViewController: BaseViewController {
    // MARK: - Properties
    private let nicknameView = NicknameView()
    private let nicknameViewModel = NicknameViewModel()
    private let disposeBag = DisposeBag()
    static var isFromGenderVC = false

    // MARK: - Life Cycle
    override func loadView() {
        view = nicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        nicknameView.userInputView.textField.text = "돌고레밥"
        nicknameView.userInputView.textField.becomeFirstResponder()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("from genderVC? \(NicknameViewController.isFromGenderVC)")
        if NicknameViewController.isFromGenderVC {
            showToast(message: String.Nickname.unavailableNickname)
        }
    }
    
    // MARK: - Binding
    private func bind() {
        let input = NicknameViewModel.Input(nickname: nicknameView.userInputView.textField.rx.text)
        let output = nicknameViewModel.transform(input)
        var isValid = false
        
        output.isValidNickname
            .drive(with: self) { vc, isValidNickname in
                vc.nicknameView.button.isActivated = isValidNickname
                isValid = isValidNickname
            }
            .disposed(by: disposeBag)
        
        nicknameView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                if isValid {
                    // 생년월일 입력 뷰로 넘기기
                    NewUser.shared.nickname = vc.nicknameView.userInputView.textField.text!
                    vc.transition(to: BirthDateViewController())
                } else {
                    vc.showToast(message: String.Nickname.nicknameLength)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension NicknameViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
