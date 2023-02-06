//
//  Transition+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/16.
//

import UIKit

extension UIViewController {
    enum TransitionStyle {
        case push
    }
    
    func transition<T: UIViewController>(to vc: T, transitionStyle: TransitionStyle = .push) {
        switch transitionStyle {
            case .push:
                navigationController?.pushViewController(vc, animated: true)
        }
    }
}
