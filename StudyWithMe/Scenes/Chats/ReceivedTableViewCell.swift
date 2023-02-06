//
//  ReceivedTableViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/10.
//

import UIKit

class ReceivedTableViewCell: ChatTableViewCell {
    // MARK: - Setting Methods
    override func setUI() {
        super.setUI()
        chatView.layer.borderWidth = 1
        chatView.layer.borderColor = Asset.Colors.Grayscale.gray4.color.cgColor
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        chatView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(chatView.snp.trailing).offset(8)
        }
    }
}
