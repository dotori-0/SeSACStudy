//
//  GenderSelectionView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/22.
//

import UIKit

class GenderSelectionView: BaseView {
    // MARK: - Properties
    let button = UIButton()
    var gender: Gender?
    let genderImageView = UIImageView().then { $0.contentMode = .scaleAspectFit }
    let genderLabel = SignUpLabel()
    var isSelectedByUser: Bool {
        didSet {
            setAppearance()
        }
    }
    
    // MARK: - Initializers
    init(gender: Gender) {
        self.gender = gender
        isSelectedByUser = false
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        [button, genderImageView, genderLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        guard let gender = gender else { return }
        setGender(as: gender)
        setAppearance()
    }
    
    private func setGender(as gender: Gender) {
        genderImageView.image = gender.image
        genderLabel.setText(with: gender.description)
    }
    
    private func setAppearance() {
        layer.cornerRadius = 8
        
        if isSelectedByUser {
            backgroundColor = Asset.Colors.BrandColor.whitegreen.color
        } else {
            layer.borderWidth = 1
            layer.borderColor = Asset.Colors.Grayscale.gray3.color.cgColor
        }
    }
    
    override func setConstraints() {
        genderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(14)
            make.width.equalToSuperview().multipliedBy(0.385)
            make.height.equalTo(genderImageView.snp.width)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(genderImageView.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-14)
            make.centerX.equalToSuperview()
        }
    }
}
