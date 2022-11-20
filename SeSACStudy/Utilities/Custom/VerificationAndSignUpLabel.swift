//
//  VerificationLabel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class VerificationAndSignUpLabel: BaseLabel {
    // MARK: - Initializers
    init(text: String = "") {
        super.init(frame: .zero)
        
        setText(with: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {
        font = .Display1_R20
        textAlignment = .center
        numberOfLines = 0
    }
    
    func setText(with text: String) {
        self.text = text
    }
}
