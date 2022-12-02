//
//  CardCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

final class CardCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
    private let cardImageView = UIImageView()
    private let usernameView = UIView()
    private let usernameLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let usernameViewHeight: CGFloat = 58
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        [usernameLabel, arrowImageView].forEach {
            usernameView.addSubview($0)
        }
        
        [cardImageView, usernameView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setUI() {
        cardImageView.then {
            $0.image = Asset.MyInfo.InfoManagement.default.image
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 8
        }
        
        usernameView.do {
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = Asset.Colors.Grayscale.gray2.color.cgColor
            $0.layer.borderWidth = 1
        }
        
        usernameLabel.do {
            $0.font = .Title1_M16
        }
        
        arrowImageView.do {
            $0.image = Asset.MyInfo.Settings.moreArrow.image
        }
    }
    
    override func setConstraints() {
        cardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview()
//            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(cardImageView.snp.width).multipliedBy(194.0/343.0)
        }
        
        // 방법 1
//        contentView.snp.makeConstraints { make in
//            let screenWidth = UIScreen.main.bounds.width
//            let cardImageWidth = screenWidth - 16 * 2
////            let cardImageWidth = screenWidth
//            let cardImageHeight = cardImageWidth * (194.0 / 343.0)
//            let cardViewHeight = cardImageHeight + usernameViewHeight + 16
//            make.height.equalTo(cardViewHeight)
//            make.width.equalTo(cardImageWidth)
////            make.width.equalToSuperview()            // 셀의 높이가 다시 44로 지정됨
////            make.horizontalEdges.equalToSuperview()  // 셀의 높이가 다시 44로 지정됨
////            make.edges.equalToSuperview()
////            make.edges.equalTo(self)
//        }
//        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-26)
        }

        usernameView.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom)
            make.width.centerX.equalTo(cardImageView)
            make.height.equalTo(usernameViewHeight)
            make.bottom.equalToSuperview().offset(-12)  // 방법 2
        }
    }
    
    func setUsername(as name: String) {
        usernameLabel.text = name
    }
}
