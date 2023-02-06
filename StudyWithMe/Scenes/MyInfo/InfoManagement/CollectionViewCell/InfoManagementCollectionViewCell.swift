//
//  InfoManagementCollectionViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

class InfoManagementCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
    let categoryLabel = UILabel().then {
        $0.font = .Title4_R14
    }
    
    var category: String = ""
    
    // MARK: - Initializers
    override init(frame: CGRect) {
//        self.category = "???"
        super.init(frame: frame)
    }
    
    init(category: String) {
        self.category = category
        super.init(frame: .zero)
    }
    
    func setCategory(category: String) {
        self.category = category
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
        contentView.addSubview(categoryLabel)
    }
    
    override func setUI() {
        setText(with: category)
    }
    
    private func setText(with text: String) {
        categoryLabel.text = text
    }
    
    override func setConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }
}
