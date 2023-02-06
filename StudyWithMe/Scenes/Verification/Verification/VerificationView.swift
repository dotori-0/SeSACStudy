//
//  VerificationView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import UIKit

final class VerificationView: VerificationAndSignUpView {
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {
        super.setText(labelText: String.Verification.inputPhoneNumber,
                      textFieldPlaceholder: String.Verification.phoneNumberPlaceholder,
                      buttonTitle: String.Verification.verify)
    }
    
    override func updateInitialConstraints() {
        userInputView.snp.updateConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(64)
        }
    }
//    
//    override func setText(labelText: String, textFieldPlaceholder: String, buttonTitle: String) {
//        super.setText(labelText: String.Verification.inputPhoneNumber,
//                      textFieldPlaceholder: String.Verification.phoneNumberPlaceholder,
//                      buttonTitle: String.Verification.verify)
//    }
    
//    private func setText() {
//
//    }
}
