//
//  VerificationViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit
import RxSwift

class VerificationViewController: BaseViewController {
    // MARK: - Properties
    let verificationView = VerificationView()
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = verificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigation()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        verificationView.phoneNumberTextField.setBottomLine()
    }
    
    // MARK: - Setting Methods
    private func setNavigation() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Binding
    private func bind() {
        verificationView.phoneNumberTextField.rx.controlEvent([.editingDidBegin, .editingChanged])
            .asDriver()
            .drive { _ in
                self.verificationView.phoneNumberTextField.changeBottomLineColorToFocus()  // CALayer
                self.verificationView.changeBottomLineColor()  // UIView
            }
            .disposed(by: disposeBag)
        
        verificationView.phoneNumberTextField.rx.controlEvent([.editingDidEnd])
            .asDriver()
            .drive { _ in
                self.verificationView.phoneNumberTextField.changeBottomLineColorToFocus()  // CALayer
//                self.verificationView.borderLine.backgroundColor = .blue  // UIView
            }
            .disposed(by: disposeBag)
    }
}

extension VerificationViewController: UITextFieldDelegate {
    // 키보드 여백 누를떄
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        verificationView.borderLine.backgroundColor = .blue
        view.endEditing(true)
    }
}
