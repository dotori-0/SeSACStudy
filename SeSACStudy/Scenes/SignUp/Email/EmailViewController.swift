//
//  EmailViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/21.
//

import UIKit
import RxSwift

class EmailViewController: BaseViewController {
    // MARK: - Properties
    private let emailView = EmailView()
    private let emailViewModel = EmailViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = emailView
    }
}
