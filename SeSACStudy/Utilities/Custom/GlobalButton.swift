//
//  GlobalButton.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class GlobalButton: UIButton {
    // MARK: - Properties
    var title: String?
    var buttonConfiguration = UIButton.Configuration.filled()

    // MARK: - Initializers
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    private func setUI() {
        guard let title = title else {
            print("No title for GlobalButton")
            return
        }

        var container = AttributeContainer()
        container.font = .Body3_R14
//        container.foregroundColor = Asset.Colors.BlackWhite.white
        
        buttonConfiguration.baseBackgroundColor = Asset.Colors.Grayscale.gray6.color
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: container)
        
        configuration = buttonConfiguration
    }
    
    func changeButtonColorToGreen() {
        buttonConfiguration.baseBackgroundColor = Asset.Colors.BrandColor.green.color
        configuration = buttonConfiguration
    }
}
