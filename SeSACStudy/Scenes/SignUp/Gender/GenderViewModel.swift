//
//  GenderViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/22.
//

import Foundation
import RxSwift

final class GenderViewModel {
    let gender = BehaviorSubject<Gender?>(value: nil)
    
    let account = PublishSubject<Void>()
    
    func signUp() {
        APIManager.signUp { [weak self] result in
            switch result {
                case .success():
                    self?.account.onNext(())
                case .failure(let error):
                    self?.account.onError(error)
            }
        }
    }
}

