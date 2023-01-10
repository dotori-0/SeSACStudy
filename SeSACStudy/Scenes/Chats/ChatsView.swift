//
//  ChatsView.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/10.
//

import UIKit

class ChatsView: BaseView {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .grouped)
    let chatInputView = UIView()
    let chatTextView = UITextView()
    let sendButton = UIButton()
    var buttonConfig = UIButton.Configuration.plain()
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        tableView.register(ReceivedTableViewCell.self, forCellReuseIdentifier: ReceivedTableViewCell.reuseIdentifier)
        tableView.register(SentTableViewCell.self, forCellReuseIdentifier: SentTableViewCell.reuseIdentifier)
        
        [chatTextView, sendButton].forEach {
            chatInputView.addSubview($0)
        }
        [tableView, chatInputView].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        chatInputView.layer.cornerRadius = 8
        chatInputView.backgroundColor = Asset.Colors.Grayscale.gray1.color
        chatTextView.backgroundColor = .clear
        
        setSendButtonImage(isTextViewEmpty: true)
    }
    
    func setSendButtonImage(isTextViewEmpty: Bool) {
        buttonConfig.image = isTextViewEmpty ? Asset.Chats.inactive.image : Asset.Chats.active.image
        sendButton.configuration = buttonConfig
    }
    
    override func setConstraints() {
        chatTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(sendButton.snp.leading).offset(-10)
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(chatTextView)
            make.trailing.equalToSuperview().offset(-14)
            make.width.equalTo(20)
        }
        
        chatInputView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(52)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(chatInputView.snp.top).offset(-12)
        }
    }
}
