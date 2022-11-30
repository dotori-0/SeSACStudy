//
//  PageView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

final class PageView: BaseView {
    // MARK: - Properties
    let label = OnboardingLabel()
    let imageView = UIImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        label.text = "TEST"
    }
    
    override func setHierarchy() {
        [label, imageView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(56)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(imageView.snp.width)
        }
    }
}
