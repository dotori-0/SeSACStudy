//
//  NicknameViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/16.
//

import UIKit

import RxSwift

class NicknameViewController: BaseViewController {
    // MARK: - Properties
    private let nicknameView = NicknameView()
    private let nicknameViewModel = LogInViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = nicknameView
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
}
