//
//  NoSelectionTextField.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/20.
//

import UIKit

final class NoSelectionTextField: NoActionTextField {
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .null
    }
    
    override func buildMenu(with builder: UIMenuBuilder) {
        builder.remove(menu: .lookup)
    }
}
