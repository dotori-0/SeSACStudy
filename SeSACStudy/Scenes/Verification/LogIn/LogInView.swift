//
//  LogInView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import UIKit

class LogInView: VerificationAndSignUpView {
    // MARK: - Properties
    let resendButton = GlobalButton(title: String.LogIn.resend)
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
//        addSubview(label)
//        addSubview(userInputView)
        super.setHierarchy()
        addSubview(resendButton)
    }
    
    override func setUI() {
        super.setText(labelText: String.LogIn.verificationCodeSent,
                      textFieldPlaceholder: String.LogIn.inputVerificationCode,
                      buttonTitle: String.LogIn.verifyAndStart)
        
        resendButton.isActivated = true
        button.isActivated = true
    }
    
    override func setConstraints() {
        super.setConstraints()
        resendButton.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-16)
//            make.centerY.equalTo(userInputView)
        }
        
//        updateConstraints()  //
//        setNeedsUpdateConstraints()
//        updateConstraintsIfNeeded()
        updateInitialConstraints()
    }
  
    
    private func updateInitialConstraints() {
        // 왜 superclass에서 이미 레이아웃 잡힌 객체를 updateConstraints하는 걸로는 안 되는지..?
        label.snp.updateConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
        }
        
//        userInputView.snp.updateConstraints { make in
//            make.leading.equalToSuperview()
//            make.top.equalTo(label.snp.bottom).offset(96)
//
//            make.trailing.equalTo(resendButton.snp.leading).offset(-8)
//        }
        
        userInputView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(label.snp.bottom).offset(96)
            make.trailing.equalTo(resendButton.snp.leading).offset(-8)
            make.height.equalTo(48)
        }
        
        resendButton.snp.makeConstraints { make in
            make.centerY.equalTo(userInputView)
        }
    }
    
    
//    override func updateConstraints() {
//        label.snp.updateConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(80)
//        }
//
//        userInputView.snp.updateConstraints { make in
//            make.top.equalTo(label.snp.bottom).offset(96)
//            make.trailing.equalTo(resendButton.snp.leading).offset(-8)
//        }
//
////        super.updateConstraints()
//    }
}
