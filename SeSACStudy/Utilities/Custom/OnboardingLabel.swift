//
//  OnboardingLabel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class OnboardingLabel: BaseLabel {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {
        font = .Display0_R24
        textAlignment = .center
        numberOfLines = 0
    }
    
    func setText(with text: String, highlight: String) {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: highlight)
        attributedString.addAttributes([.font: UIFont.Display0_M24, .foregroundColor: Asset.Colors.BrandColor.green.color], range: range)
        attributedText = attributedString
    }
    
    func setText(with text: String) {
        self.text = text
        font = .Display0_M24
        textColor = Asset.Colors.BlackWhite.black.color
    }
}
