//
//  AddAttributes+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/29.
//

import UIKit

extension String {
    func addAttributes(font: UIFont?, textColor: UIColor) -> NSAttributedString {
//        let attributes: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: textColor]
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: textColor]
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
}
