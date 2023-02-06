//
//  InputOutput.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import Foundation

protocol InputOutput {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
