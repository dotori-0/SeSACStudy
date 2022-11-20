//
//  BirthDateViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/19.
//

import UIKit
import RxSwift

class BirthDateViewController: BaseViewController {
    // MARK: - Properties
    private let birthDateView = BirthDateView()
    private let birthDateViewModel = BirthDateViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = birthDateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        birthDateView.yearInputView.textField.becomeFirstResponder()
//        birthDateView.yearInputView.textField.isUserInteractionEnabled = false
//        birthDateView.yearInputView.textField.isEnabled = false
//        birthDateView.yearInputView.textField.textDragOptions =
        
        birthDateView.yearInputView.textField.delegate = self
        birthDateView.monthInputView.textField.delegate = self
        birthDateView.dayInputView.textField.delegate = self
        
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        let input = BirthDateViewModel.Input(date: birthDateView.datePicker.rx.date)
        let output = birthDateViewModel.transform(input)
        var isValid = false
        
        output.year
//            .withUnretained(self)  // rx 객체에 bind 하는 거라면 self 필요 없는 것..? ❔
            .bind(to: birthDateView.yearInputView.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.month
            .bind(to: birthDateView.monthInputView.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.day
            .bind(to: birthDateView.dayInputView.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.isValidAge
            .drive(with: self) { vc, isValidAge in
                vc.birthDateView.button.isActivated = isValidAge
                isValid = isValidAge
            }
            .disposed(by: disposeBag)        
        
        birthDateView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                if isValid {
                    // 이메일 입력 뷰로 넘기기
//                    NewUser.shared.birthDate
                } else {
                    vc.showToast(message: String.BirthDate.underage)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension BirthDateViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return false
//    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
