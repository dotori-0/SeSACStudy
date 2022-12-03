//
//  GenderCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

class GenderCollectionViewCell: InfoManagementCollectionViewCell {
    // MARK: - Properties
//    weak var delegate: GenderCellDelegate?
    let maleView = MyGenderView(gender: .male)
    let femaleView = MyGenderView(gender: .female)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
//        super.init(frame: frame)
        super.init(category: String.MyInfo.InfoManagement.gender)
//        setCategory(category: String.MyInfo.InfoManagement.gender)
        
        setActions()
    }
    
//    override init(category: String) {
//        super.init(category: String.MyInfo.InfoManagement.gender)
//    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        super.setHierarchy()
//        setCategory(category: String.MyInfo.InfoManagement.gender)
        [maleView, femaleView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()  // 안하면 어찌되는지 확인하기
        
        femaleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(56.0/375.0)
            make.height.equalTo(femaleView.snp.width).multipliedBy(48.0/56.0)
        }
        
        maleView.snp.makeConstraints { make in
            make.centerY.width.height.equalTo(femaleView)
            make.trailing.equalTo(femaleView.snp.leading).offset(-8)
        }
    }
    
    private func setActions() {
        maleView.button.addTarget(self, action: #selector(maleViewTapped), for: .touchUpInside)
        femaleView.button.addTarget(self, action: #selector(femaleViewTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc private func maleViewTapped() {
        maleView.isSelectedByUser = true
        femaleView.isSelectedByUser = false
    }
    
    @objc private func femaleViewTapped() {
        maleView.isSelectedByUser = false
        femaleView.isSelectedByUser = true
    }
}

//protocol GenderCellDelegate: AnyObject {
////    func didSelectGender(of genderView: MyGenderView)
//    func didSelectGender(as gender: Gender, at cell: GenderCollectionViewCell)
//}
