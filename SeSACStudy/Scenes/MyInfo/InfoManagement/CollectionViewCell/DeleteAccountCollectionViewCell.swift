//
//  DeleteAccountCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/03.
//

import UIKit

class DeleteAccountCollectionViewCell: InfoManagementCollectionViewCell {
    // MARK: - Properties
    let deleteAccountButton = UIButton()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(category: String.MyInfo.InfoManagement.deleteAccount)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        super.setHierarchy()
        
        contentView.addSubview(deleteAccountButton)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
//        categoryLabel.backgroundColor = .systemBlue
//        deleteAccountButton.backgroundColor = .systemYellow.withAlphaComponent(0.3)
        
//        categoryLabel.snp.remakeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.height.equalToSuperview().dividedBy(3)
//        }
        
        deleteAccountButton.snp.makeConstraints { make in
//            make.edges.equalTo(categoryLabel)  // 안 됨 (버튼의 높이가 높아지고 레이블의 높이도 높아짐)
//            make.verticalEdges.equalTo(categoryLabel)
            make.horizontalEdges.equalTo(categoryLabel)
            
            // 여기까지만 하면 레이블의 높이가 달라지거나 셀의 컨텐트뷰의 높이가 달라지지는 않지만 missing constraints가 뜨지 않는 이유? ❔
            make.centerY.equalToSuperview()
            
            // 버튼의 높이가 높아지고 레이블의 높이도 높아짐
//            make.height.equalTo(categoryLabel)
//            make.height.equalToSuperview().dividedBy(3)
        }
    }
}
