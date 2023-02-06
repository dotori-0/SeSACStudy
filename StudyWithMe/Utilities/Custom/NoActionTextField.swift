//
//  NoActionTextField.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/12.
//

import UIKit

class NoActionTextField: UITextField {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
