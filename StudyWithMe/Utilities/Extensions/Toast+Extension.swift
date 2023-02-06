//
//  Toast+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import UIKit

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        view.makeToast(message,
                       duration: duration,
                       position: .center,
                       completion: completion)
    }
}

extension BaseView {
    func showToast(message: String, duration: TimeInterval = 0.5, completion: ((Bool) -> Void)? = nil) {
        makeToast(message,
                  duration: duration,
                  position: .center,
                  completion: completion)
    }
}
