//
//  NicknameView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/16.
//

import UIKit

class NicknameView: VerificationAndSignUpView {
    // MARK: - Setting Methods
    override func setUI() {
        super.setText(labelText: String.Nickname.inputNickname,
                      textFieldPlaceholder: String.Nickname.nicknamePlaceholder,
                      buttonTitle: String.Action.next)
        
        button.isActivated = false  // rx 연결 후 지워보기...👻
    }
    
    override func updateInitialConstraints() {
        label.snp.updateConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(96)
        }
    }
}
