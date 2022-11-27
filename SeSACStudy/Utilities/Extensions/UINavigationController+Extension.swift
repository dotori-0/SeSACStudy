//
//  UINavigationController+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/26.
//

import UIKit

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
//        if let vc = viewControllers.last(where: { $0 is ofClass }) {  // 왜 안되는지,,, ❔
            popToViewController(vc, animated: animated)
        }
    }
}
