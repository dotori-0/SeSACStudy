//
//  EmailView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/21.
//

import UIKit

class EmailView: VerificationAndSignUpView {
    // MARK: - Properties
    let detailsLabel = SignUpLabel(text: String.Email.detailedExplanation,
                                   isGray: true)
    
    // MARK: - Setting Methods
    override func setUI() {
        super.setText(labelText: String.Email.inputEmail,
                      textFieldPlaceholder: String.Email.emailPlaceholder,
                      buttonTitle: String.Action.next)
        
//        userInputView = InputView(isNumberPad: false)
        userInputView.changeKeyboardType(to: .emailAddress)
    }
    
    override func setHierarchy() {
        super.setHierarchy()
        
        addSubview(detailsLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    override func updateInitialConstraints() {
        userInputView.snp.remakeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(63)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
