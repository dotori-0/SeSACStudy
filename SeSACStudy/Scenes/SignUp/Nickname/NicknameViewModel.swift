//
//  NicknameViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/16.
//

import UIKit

import RxCocoa
import RxSwift

class NicknameViewModel: InputOutput {
    struct Input {
        let nickname: ControlProperty<String?>
    }
    
    struct Output {
        let isValidNickname: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let isValidNickname = validate(nickname: input.nickname)
        return Output(isValidNickname: isValidNickname)
    }
    
    private func validate(nickname: ControlProperty<String?>) -> Driver<Bool> {
        let isValid = nickname.orEmpty
//            .map { $0.count >= 1 && $0.count <= 10 }
            .map { (1...10).contains($0.count) }
            .asDriver(onErrorJustReturn: false)
        
        return isValid
    }
}
