//
//  InfoManagementTableViewCell.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

class InfoManagementTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let categoryLabel = UILabel().then {
        $0.font = .Title4_R14
    }
    
    var category: String
    
    // MARK: - Initializers
    init(category: String) {
        self.category = category
        super.init(style: .default, reuseIdentifier: nil)  // UITableViewCell을 상속하는 BaseTableViewCell을 상속하는 클래스에서는 super.init을 어떻게 해야할지..?❔
        
//        setText(with: category)
    }
    
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
            make.leading.equalToSuperview().offset(16)
        }
    }
}
