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
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
    
    private func validate(nickname: ControlProperty<String?>) -> Driver<Bool> {
        let isValid = nickname.orEmpty
//            .map { $0.count >= 1 && $0.count <= 10 }
            .map { (1...10).contains($0.count) }
            .asDriver(onErrorJustReturn: false)
        
        return isValid
    }
}
