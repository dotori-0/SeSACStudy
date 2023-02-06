//
//  ChatTableViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/10.
//

import UIKit

class ChatTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let chatLabel = ChatLabel()
    let chatView = UIView()
    let timeLabel = ChatTimeLabel()
 
    // MARK: - Setting Methods
    override func setHierarchy() {
        chatView.addSubview(chatLabel)
        [chatView, timeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setUI() {
        chatView.layer.cornerRadius = 8
    }
    
    override func setConstraints() {
        chatLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        chatView.snp.makeConstraints { make in
//            make.width.greaterThanOrEqualToSuperview().dividedBy(2)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.7)
//            make.centerY.equalToSuperview()  // UITableView.automaticDimension 동작 X!
//            make.verticalEdges.equalToSuperview()  // UITableView.automaticDimension 동작 O!
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(chatView)
        }
    }
}
