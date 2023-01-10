//
//  ChatLabel.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/10.
//

import UIKit

class ChatLabel: BaseLabel {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .Body3_R14
        textColor = Asset.Colors.BlackWhite.black.color
        numberOfLines = 0
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
