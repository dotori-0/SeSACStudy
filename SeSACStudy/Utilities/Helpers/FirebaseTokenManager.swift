//
//  FirebaseTokenManager.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/16.
//

import UIKit
import FirebaseAuth

extension UIViewController {
    func refreshIDToken(completion: (() -> Void)? = nil) {
        print(#function)
        let currentUser = Auth.auth().currentUser
        // objective-c 메서드인 것 같은데... ❔
        print("currentUser: \(currentUser)")
        
        currentUser?.getIDTokenForcingRefresh(true) { [weak self] idToken, error in
            print("getIDTokenForcingRefresh")
            if let error = error {  // 토큰을 받아오거나 refresh해서 받아오는 데 실패
                print(error)
                self?.showToast(message: String.LogIn.idTokenError)
                return
            } else if let idToken {
                print("🪙 \(idToken)")
                UserDefaults.idToken = idToken
                completion?()
            }
        }
    }
}
