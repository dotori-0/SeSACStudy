//
//  LogInViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import Foundation

import RxCocoa
import RxSwift
 
final class LogInViewModel: InputOutput {
    struct Input {
        let verificationCode: ControlProperty<String?>
    }
    
    struct Output {
        let limitedCode: Driver<String>
        let isValidCode: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let limitedCode = limit(verificationCode: input.verificationCode)
//        let isValidCode = validate(verificationCode: input.verificationCode)
        let isValidCode = validate(verificationCode: limitedCode)
        return Output(limitedCode: limitedCode,
                      isValidCode: isValidCode)
    }
    
    private func limit(verificationCode: ControlProperty<String?>) -> Driver<String> {
        let limitedCode = verificationCode.orEmpty
            .map {
                if $0.count > 6 {
                    let endIndex = $0.index($0.startIndex, offsetBy: 6)
                    let limitedCode = String($0[..<endIndex])  // removeSubrange 써 보기 👻
                    return limitedCode
                } else {
                    return $0
                }
            }
            .asDriver(onErrorJustReturn: "")
        
        return limitedCode
    }
    
    private func validate(verificationCode: Driver<String>) -> Driver<Bool> {
        let regex = "^[0-9]{6}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = verificationCode.map { predicate.evaluate(with: $0) }
        
        return isValid.asDriver(onErrorJustReturn: false)
    }

    // MARK: - 로그인
    let user = PublishSubject<User>()
    
    func logIn() {
        APIManager.logIn { [weak self] result in
            switch result {
                case .success(let user):
                    self?.user.onNext(user)
                case .failure(let error):
                    print("🐣 LogInViewModel logIn() failure")
                    print("🐣", error)
                    self?.user.onError(error)
            }
        }
    }
}
