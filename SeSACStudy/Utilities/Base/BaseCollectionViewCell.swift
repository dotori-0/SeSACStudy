//
//  BaseCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    func setHierarchy() { }
    
    func setUI() { }
    
    func setConstraints() { }
}
