//
//  SentTableViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/10.
//

import UIKit

class SentTableViewCell: ChatTableViewCell {
    // MARK: - Setting Methods
    override func setUI() {
        super.setUI()
        chatView.backgroundColor = Asset.Colors.BrandColor.whitegreen.color
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        chatView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chatView.snp.leading).offset(-8)
        }
    }
}
