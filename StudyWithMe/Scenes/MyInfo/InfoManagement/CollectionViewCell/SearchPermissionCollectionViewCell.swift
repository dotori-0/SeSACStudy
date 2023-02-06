//
//  SearchPermissionCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/03.
//

import UIKit

class SearchPermissionCollectionViewCell: InfoManagementCollectionViewCell {
    // MARK: - Properties
    let toggleSwitch = UISwitch()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(category: String.MyInfo.InfoManagement.searchPermission)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubview(toggleSwitch)
    }
    
    override func setUI() {
        super.setUI()
        
        toggleSwitch.onTintColor = Asset.Colors.BrandColor.green.color
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        toggleSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-4)
        }
    }
}
