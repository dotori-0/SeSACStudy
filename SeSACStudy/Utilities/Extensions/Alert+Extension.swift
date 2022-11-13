//
//  Alert+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/13.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: String.ok, style: .default, handler: handler)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
