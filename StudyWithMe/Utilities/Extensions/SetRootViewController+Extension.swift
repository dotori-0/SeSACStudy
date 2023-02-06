//
//  SetRootViewController+Extension.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/28.
//

import UIKit

extension UIViewController {
    func setRootVCToTabBarController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = TabBarController()
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
