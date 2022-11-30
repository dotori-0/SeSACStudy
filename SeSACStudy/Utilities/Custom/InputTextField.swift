//
//  InputTextField.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

final class InputTextField: UITextField {
    // MARK: - Properties
//    var placeholder: String?
    let bottomLine = CALayer()
    
    // MARK: - Initializers
    init(placeholder: String = "") {
        super.init(frame: .zero)
        
        setUI()
        setPlaceholder(as: placeholder)
//        setBottomLine()
        addInset()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    private func setUI() {
        font = .Title4_R14
        textColor = Asset.Colors.BlackWhite.black.color
        borderStyle = .none
    }
    
    private func setPlaceholder(as placeholder: String) {
        self.placeholder = placeholder
        
    }
    
    func setBottomLine() {
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        bottomLine.backgroundColor = Asset.Colors.Grayscale.gray3.color.cgColor
        layer.addSublayer(bottomLine)
    }
    
    func changeBottomLineColorToFocus() {
        print(#function)
//        bottomLine.removeFromSuperlayer()
        bottomLine.backgroundColor = Asset.Colors.SystemColor.focus.color.cgColor
        layer.addSublayer(bottomLine)
        layoutSubviews()
    }
    
    private func addInset() {
        let insetView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftView = insetView
        self.leftViewMode = .always
    }
}
