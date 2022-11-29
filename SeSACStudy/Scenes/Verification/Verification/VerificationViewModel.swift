//
//  VerificationViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/11.
//

import Foundation

import RxCocoa
import RxSwift

final class VerificationViewModel: InputOutput {
    struct Input {
        //        let editingDidBegin: ControlEvent<Void>  // verificationView.phoneNumberInputView.textField.rx.controlEvent([.editingDidBegin])
        //        let editingDidEnd: ControlEvent<Void>
        let phoneNumber: ControlProperty<String?>
        let verifyButtonTap: ControlEvent<Void>  // 그대로 내보낼 객체들도 인풋 아웃풋에 넣는 게 나은 건지? ❔
    }
    
    struct Output {
        //        let editingDidBegin: Driver<Void>  // typealias Driver<Element> = SharedSequence<DriverSharingStrategy, Element>
        //        let editingDidEnd: Driver<Void>
        let number: Driver<String>
        let isValidNumber: Observable<Bool>
        let verifyButtonTap: ControlEvent<Void>
        let prefixedNumber: String
    }
    
    func transform(_ input: Input) -> Output {
        //        let editingDidBegin = input.editingDidBegin.asDriver()  // SharedSequence<DriverSharingStrategy, ()>
        //        let editingDidEnd = input.editingDidEnd.asDriver()
        let unhyphenatedNumber = unhyphenAndLimit(number: input.phoneNumber)
        let number = hyphenate(unhyphenatedNumber)
        let isValidNumber = validate(phoneNumber: unhyphenatedNumber)
        let prefixedNumber = prefixCountryCodes(to: unhyphenatedNumber)
        
//        print("input.phoneNumber: \(input.phoneNumber)")
        print("unhyphenatedNumber: \(unhyphenatedNumber)")
        print("number: \(number)")
        print("prefixedNumber: \(prefixedNumber)")
        
        //        return Output(editingDidBegin: editingDidBegin,
        //                      editingDidEnd: editingDidEnd,
        return Output(number: number,
                      isValidNumber: isValidNumber,
                      verifyButtonTap: input.verifyButtonTap,
                      prefixedNumber: prefixedNumber)
    }
    
    private func unhyphenAndLimit(number: ControlProperty<String?>) -> Observable<String> {
        let unhyphenatedNumber = number.orEmpty.map {
            print("input.phoneNumber: \($0)")
            return $0.components(separatedBy: "-").joined()
        }
        let limitedNumber = unhyphenatedNumber.map {
            if $0.count > 11 {
                let endIndex = $0.index($0.startIndex, offsetBy: 11)
                let limitedNumber = String($0[..<endIndex])  // removeSubrange 써 보기 👻
                return limitedNumber
            } else {
                return $0
            }
        }
        
        return limitedNumber
    }
    
    private func validate(phoneNumber: Observable<String>) -> Observable<Bool> {
        let phoneNumberRegEx = "^01[0-1, 7][0-9]{7,8}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
        let isValid = phoneNumber.map { phoneNumberPredicate.evaluate(with: $0) }
        
        return isValid
    }
    
    private func hyphenate(_ unhyphenatedNumber: Observable<String>) -> Driver<String> {
        print("👏🏻")
        guard let shortRegex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{1,3})", options: .caseInsensitive) else {
            return BehaviorRelay(value: "").asDriver()
        }
        
        guard let mediumRegex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{1,3})([0-9]{1,3})", options: .caseInsensitive) else {
            return BehaviorRelay(value: "").asDriver()
        }
        
        guard let longRegex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) else {
            return BehaviorRelay(value: "").asDriver()
            //            return PublishSubject<String>().asDriver(onErrorJustReturn: "")
        }
        
        let shortTemplate = "$1-$2"
        let longTemplate = "$1-$2-$3"
        var template = ""
        var regex = NSRegularExpression()
        
        // 외않되는지... ❔
        //        let disposeBag = DisposeBag()
        //        var numberCount = 0
        //        number.orEmpty.map { $0.components(separatedBy: "-").joined().count }
        //            .subscribe(onNext: { count in
        //                numberCount = count
        //                print(#function, numberCount)
        //            })
        //            .disposed(by: disposeBag)
        //
        //        print("numberCount: \(numberCount)")
        
        
        //        number.orEmpty
        //            .map {
        //                let numCount = $0.components(separatedBy: "-").joined().count
        //                if numCount >= 4 && numCount <= 6 {
        //                    regex = shortRegex
        //                    template = shortTemplate
        //                } else {
        //                    regex = longRegex
        //                    template = longTemplate
        //                }
        //
        ////                return numCount
        ////                numberCount = numCount
        ////                print("💕 \(numberCount)")
        //            }
        
        
        let hyphenatedNumber = unhyphenatedNumber
            .map {
                //                                            var number = $0
                let numCount = $0.count
                switch numCount {
                    case 4...6:
                        regex = shortRegex
                        template = shortTemplate
                    case 7...9:
                        regex = mediumRegex
                        template = longTemplate
                    default:
                        regex = longRegex
                        template = longTemplate
                }
                
                let hyphenatedNumber = regex.stringByReplacingMatches(in: $0,
                                                                      options: [],
                                                                      range: NSRange($0.startIndex..., in: $0),
                                                                      withTemplate: template)
                
                return hyphenatedNumber
            }
            .asDriver(onErrorJustReturn: "")
        
        return hyphenatedNumber
    }
    
    private func prefixCountryCodes(to number: Observable<String>) -> String {
//        let prefixedNumber = BehaviorSubject(value: "")  // prefixedNumber.value()
        let prefixedNumber = BehaviorRelay(value: "")  // prefixedNumber.value
//        let prefixedNumber = PublishSubject<String>()  // prefixedNumber.values: AsyncThrowingStream<String, Error> { get }
//        let prefixedNumber = PublishRelay<String>()  // prefixedNumber.values: AsyncThrowingStream<String, Error> { get }
        
        number.map {
            print("$0: \($0)")
            print("$0.dropFirst(): \($0.dropFirst())")
            return "+82\(String($0.dropFirst()))"
        }
        .bind(to: prefixedNumber)
        .disposed(by: DisposeBag())  // 뷰모델 안에서도 DisposeBag 객체를 만들어야 할지?❔
        
        return prefixedNumber.value
    }
}
