//
//  CardTableViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

final class CardTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let cardImageView = UIImageView()
    let usernameView = UIView()
    let usernameLabel = UILabel()
    let arrowImageView = UIImageView()
    
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
    }
    
    func setUsername(as name: String) {
        usernameLabel.text = name
    }
}
