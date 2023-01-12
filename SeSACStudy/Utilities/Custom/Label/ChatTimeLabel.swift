//
//  ChatTimeLabel.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/10.
//

import UIKit

class ChatTimeLabel: BaseLabel {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .Title6_R12
        textColor = Asset.Colors.Grayscale.gray6.color
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
