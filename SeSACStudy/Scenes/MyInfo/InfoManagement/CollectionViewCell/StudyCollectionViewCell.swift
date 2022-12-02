//
//  StudyCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/02.
//

import UIKit

class StudyCollectionViewCell: InfoManagementCollectionViewCell {
    // MARK: - Properties
    let textField = UITextField()
    let bottomLineView = UIView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(category: String.MyInfo.InfoManagement.study)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        super.setHierarchy()
        
        [textField, bottomLineView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setUI() {
        super.setUI()
        // 재사용하도록 바꾸기
        textField.attributedPlaceholder = NSAttributedString(string: String.MyInfo.InfoManagement.inputStudy,
                                                             attributes: [.font: UIFont.Title4_R14,
                                                                          .foregroundColor: Asset.Colors.Grayscale.gray7.color])
        
        bottomLineView.backgroundColor = Asset.Colors.Grayscale.gray3.color
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        bottomLineView.snp.makeConstraints { make in
            make.bottom.equalTo(textField.snp.bottom).offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(164)
            make.height.equalTo(1)
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(bottomLineView).inset(12)
            make.centerY.equalToSuperview()
        }
    }
}
