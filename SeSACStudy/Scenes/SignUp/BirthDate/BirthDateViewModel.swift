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
    }
    
    func transform(_ input: Input) -> Output {
        let dateComponents = input.date.map {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: $0)
            return components
        }

        return Output(year: year(of: dateComponents),
                      month: month(of: dateComponents),
                      day: day(of: dateComponents))
    }
    
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
}
