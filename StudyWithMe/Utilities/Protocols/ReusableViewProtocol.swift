//
//  ReusableViewProtocol.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/28.
//

import UIKit

public protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReusableViewProtocol { }
