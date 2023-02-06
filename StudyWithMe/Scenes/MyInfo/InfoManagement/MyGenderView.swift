//
//  MyGenderView.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/02.
//

import UIKit

class MyGenderView: BaseView {
    // MARK: - Properties
    let button = UIButton()
    var gender: Gender?
    let genderLabel = UILabel()
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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        [button, genderLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setUI() {
        genderLabel.font = .Body3_R14
        
        guard let gender = gender else { return }
        setGender(as: gender)
        setAppearance()
    }
    
    private func setGender(as gender: Gender) {
        genderLabel.text = gender.description
    }
    
    private func setAppearance() {
        layer.cornerRadius = 8
        
        if isSelectedByUser {
            backgroundColor = Asset.Colors.BrandColor.green.color
            layer.borderColor = UIColor.clear.cgColor
            genderLabel.textColor = Asset.Colors.BlackWhite.white.color
        } else {
            backgroundColor = nil
            layer.borderWidth = 1
            layer.borderColor = Asset.Colors.Grayscale.gray4.color.cgColor
            genderLabel.textColor = Asset.Colors.BlackWhite.black.color
        }
    }
    
    override func setConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        genderLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
