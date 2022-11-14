//
//  BaseView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit
import SnapKit
import Then

class BaseView: UIView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    func setHierarchy() { }
    
    func setUI() { }
    
    func setConstraints() { }
}
