//
//  BirthDateViewModel.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/19.
//

import Foundation

import RxCocoa
import RxSwift

class BirthDateViewModel: InputOutput {
    struct Input {
        let date: ControlProperty<Date>
    }
    
    struct Output {
        let year: Observable<String>
        let month: Observable<String>
        let day: Observable<String>
        let isValidAge: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let dateComponents = input.date.map {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: $0)
            return components
        }

        return Output(year: year(of: dateComponents),
                      month: month(of: dateComponents),
                      day: day(of: dateComponents),
                      isValidAge: validate(age: age(from: dateComponents)))
    }
    
    // MARK: - Calculation
    private func year(of dateComponents: Observable<DateComponents>) -> Observable<String> {
        let year = dateComponents.map {
            guard let year = $0.year else { return String() }
            return String(year)
        }
        
        
        return year
    }
    
    private func month(of dateComponents: Observable<DateComponents>) -> Observable<String> {
        let month = dateComponents.map {
            guard let month = $0.month else { return String() }
            return String(month)
        }
        
        return month
    }
    
    private func day(of dateComponents: Observable<DateComponents>) -> Observable<String> {
        let day = dateComponents.map {
            guard let day = $0.day else { return String() }
            return String(day)
        }
        
        return day
    }
    
    private func age(from dateComponents: Observable<DateComponents>) -> Observable<Int> {
        dateComponents.map {
            guard let date = Calendar.current.date(from: $0) else { return Int() }
            
            // Calendar를 명시하지 않고 dateComponent.date를 가져올 경우 nil
//            guard let date = $0.date else {
//                print("date 없음")
//                return Int() }
            
            let elapsedTime = Calendar.current.dateComponents([.year],
                                                              from: date,
                                                              to: Date.now)
            
            guard let year = elapsedTime.year else { return Int() }
            
            return year
        }
    }
    
    private func age2(from dateComponents: Observable<DateComponents>) -> Observable<Int> {
        let year = dateComponents.map {
            guard let date = $0.date else { return Int() }
            
            let elapsedTime = Calendar.current.dateComponents([.year],
                                                              from: date,
                                                              to: Date.now)
            
            guard let year = elapsedTime.year else { return Int() }
            
            return year
        }
        
        return year
    }
    
    // MARK: - Validation
    private func validate(age: Observable<Int>) -> Driver<Bool> {
        let isValid = age.map { $0 >= 17 }
            .asDriver(onErrorJustReturn: false)
        
        return isValid
    }
}
