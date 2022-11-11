//
//  VerificationViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/11.
//

import Foundation

import RxCocoa
import RxSwift

final class VerificationViewModel {
    struct Input {
        let editingDidBegin: ControlEvent<Void>  // verificationView.phoneNumberInputView.textField.rx.controlEvent([.editingDidBegin])
        let editingDidEnd: ControlEvent<Void>
        let phoneNumber: ControlProperty<String?>
    }
    
    struct Output {
        let editingDidBegin: Driver<Void>  // typealias Driver<Element> = SharedSequence<DriverSharingStrategy, Element>
        let editingDidEnd: Driver<Void>
        let number: Driver<String>
        let isValidNumber: Observable<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let editingDidBegin = input.editingDidBegin.asDriver()  // SharedSequence<DriverSharingStrategy, ()>
        let editingDidEnd = input.editingDidEnd.asDriver()
        let number = hyphenate(number: input.phoneNumber)
        let isValidNumber = validate(phoneNumber: input.phoneNumber)
        
        return Output(editingDidBegin: editingDidBegin,
                      editingDidEnd: editingDidEnd,
                      number: number,
                      isValidNumber: isValidNumber)
    }
    
    private func validate(phoneNumber: ControlProperty<String?>) -> Observable<Bool> {
        let phoneNumberRegEx = "^01[0-1, 7][0-9]{7,8}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
        let unhyphenatedNumber = phoneNumber.orEmpty.map { $0.components(separatedBy: "-").joined() }
        let isValid = unhyphenatedNumber.map { phoneNumberPredicate.evaluate(with: $0) }
        
        return isValid
    }
    
    private func hyphenate(number: ControlProperty<String?>) -> Driver<String> {
        guard let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) else {
            return BehaviorRelay(value: "").asDriver()
//            return PublishSubject<String>().asDriver(onErrorJustReturn: "")
        }
        
        let hyphenatedNumber = number.orEmpty
                                        .map {
                                            regex.stringByReplacingMatches(in: $0,
                                                                           options: [],
                                                                           range: NSRange($0.startIndex..., in: $0),
                                                                           withTemplate: "$1-$2-$3")
                                        }
                                        .asDriver(onErrorJustReturn: "")

        return hyphenatedNumber
    }
}
