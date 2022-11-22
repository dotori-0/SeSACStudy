//
//  EmailViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/21.
//

import Foundation
import RxCocoa

class EmailViewModel: InputOutput {
    struct Input {
        let email: ControlProperty<String?>
    }
    
    struct Output {
        let isValidEmail: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        return Output(isValidEmail: validate(email: input.email))
    }
    
    private func validate(email: ControlProperty<String?>) -> Driver<Bool> {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        let isValid = email.orEmpty
                            .map { emailTest.evaluate(with: $0) }
                            .asDriver(onErrorJustReturn: false)
        
        return isValid
    }
}
