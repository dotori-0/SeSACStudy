//
//  SignUpLabel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/19.
//

import UIKit

final class SignUpLabel: BaseLabel {
    var isGray = false
    
    // MARK: - Initializers
    init(text: String = "", isGray: Bool = false) {
        self.isGray = isGray
        super.init(frame: .zero)
        
        setText(with: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {
        font = .Title2_R16
        textColor = isGray ? Asset.Colors.Grayscale.gray7.color : Asset.Colors.BlackWhite.black.color
//        textColor = isGray ? Asset.Colors.BrandColor.green.color : Asset.Colors.BlackWhite.black.color
        textAlignment = .center
        numberOfLines = 0
    }
    
    func setText(with text: String) {
        self.text = text
    }
}
