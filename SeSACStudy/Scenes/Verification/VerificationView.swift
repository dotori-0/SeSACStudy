//
//  VerificationView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class VerificationView: BaseView {
    // MARK: - Properties
    private let label = VerificationLabel(text: String.Verification.inputPhoneNumber)
    let phoneNumberTextField = InputTextField(placeholder: String.Verification.phoneNumberPlaceholder).then {
        $0.keyboardType = .numberPad
    }
    let verifyButton = GlobalButton(title: String.Verification.verify)
    let borderLine = UIView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {

    }
    
    override func setHierarchy() {
        [label, phoneNumberTextField, borderLine, verifyButton].forEach {
            addSubview($0)
        }
        
        setBottomLineView()
    }
    
    func setBottomLineView() {
//        self.addSubview(borderLine)
//        borderLine.frame = CGRect(x: 0, y: Double(phoneNumberTextField.frame.height) - 5, width: Double(phoneNumberTextField.frame.width), height: 2)
        borderLine.backgroundColor = UIColor.blue

//        phoneNumberTextField.borderStyle = .none

    }
    
    func changeBottomLineColor() {
        borderLine.backgroundColor = UIColor.systemGreen
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(124)
            make.horizontalEdges.equalToSuperview()
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(64)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        borderLine.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(5)
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(72)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
