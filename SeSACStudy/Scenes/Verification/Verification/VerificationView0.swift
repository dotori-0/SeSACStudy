//
//  VerificationView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class VerificationView0: BaseView {
    // MARK: - Properties
    private let label = VerificationAndSignUpLabel(text: String.Verification.inputPhoneNumber)
    let phoneNumberTextField = InputTextField(placeholder: String.Verification.phoneNumberPlaceholder).then {
        $0.keyboardType = .numberPad
    }
    let verifyButton = GlobalButton(title: String.Verification.verify)
    let phoneNumberInputView = InputView(placeholder: String.Verification.phoneNumberPlaceholder)
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        textFieldWithCALayer()  // CALayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {

    }
    
    override func setHierarchy() {
        [label, phoneNumberInputView, verifyButton].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(124)
            make.horizontalEdges.equalToSuperview()
        }
        
        phoneNumberInputView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberInputView.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    // MARK: - Experimental Methods
    func textFieldWithCALayer() {
        addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
