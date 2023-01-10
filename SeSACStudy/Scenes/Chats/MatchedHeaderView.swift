//
//  MatchedHeaderView.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/11.
//

import UIKit

class MatchedHeaderView: BaseView {
    // MARK: - Properties
    let matchedDateView = UIView()
    let matchedDateLabel = UILabel()
    let matchedLabel = UILabel()
    let guideLabel = UILabel()
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        matchedDateView.addSubview(matchedDateLabel)
        [matchedDateView, matchedLabel, guideLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        backgroundColor = Asset.Colors.BlackWhite.white.color
        setMatchedDateLabel()
        setMatchedDateView()
        setMatchedLabel()
        setGuideLabel()
    }
    
    override func setConstraints() {
        matchedDateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(6)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        matchedDateView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        matchedLabel.snp.makeConstraints { make in
            make.top.equalTo(matchedDateLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(matchedLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)  // bottom 잡지 않으면 heightForHeaderInSection의 UITableView.automaticDimension 동작 X
        }
    }
    
    // MARK: - Design Methods
    private func setMatchedDateLabel() {
        matchedDateLabel.text = "1월 8일 일요일"
        matchedDateLabel.textColor = Asset.Colors.BlackWhite.white.color
        matchedDateLabel.font = .Title5_M12
    }
    
    private func setMatchedDateView() {
        matchedDateView.backgroundColor = Asset.Colors.Grayscale.gray7.color
        DispatchQueue.main.async { [weak self] in
            self?.matchedDateView.layer.cornerRadius = (self?.matchedDateView.frame.height)! / 2
        }
    }
    
    private func setMatchedLabel() {
        matchedLabel.text = "🔔 고래밥" + String.Chats.matchedWith
        matchedLabel.font = .Title3_M14
        matchedLabel.textColor = Asset.Colors.Grayscale.gray7.color
    }
    
    private func setGuideLabel() {
        guideLabel.font = .Title4_R14
        guideLabel.textColor = Asset.Colors.Grayscale.gray6.color
        guideLabel.text = String.Chats.guide
    }
}
