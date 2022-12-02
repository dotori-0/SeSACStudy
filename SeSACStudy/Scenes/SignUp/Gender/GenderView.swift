//
//  GenderView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/22.
//

import UIKit

final class GenderView: VerificationAndSignUpView {
    // MARK: - Properties
    let detailsLabel = SignUpLabel(text: String.Gender.detailedExplanation,
                                   isGray: true)
    let maleSelectionView = GenderSelectionView(gender: .male)
    let femaleSelectionView = GenderSelectionView(gender: .female)
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        super.setHierarchy()
        
        [detailsLabel, maleSelectionView, femaleSelectionView].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        super.setText(labelText: String.Gender.selectGender,
                      buttonTitle: String.Action.next)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        userInputView.removeFromSuperview()
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        maleSelectionView.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.centerX).offset(-6)
            make.height.equalTo(120)
        }
        
        femaleSelectionView.snp.makeConstraints { make in
            make.top.equalTo(maleSelectionView)
            make.leading.equalTo(safeAreaLayoutGuide.snp.centerX).offset(6)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(maleSelectionView)
        }
    }
    
    override func updateInitialConstraints() {
        button.snp.makeConstraints { make in  // remake 하지 않아도 되는 이유? ❔
            make.top.equalTo(femaleSelectionView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
