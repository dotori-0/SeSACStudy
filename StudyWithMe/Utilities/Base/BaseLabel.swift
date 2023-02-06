//
//  BaseLabel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class BaseLabel: UILabel {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    func setUI() { }
}
