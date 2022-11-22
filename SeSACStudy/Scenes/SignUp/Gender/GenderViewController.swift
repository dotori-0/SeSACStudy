//
//  GenderViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/22.
//

import UIKit
import RxSwift

class GenderViewController: BaseViewController {
    // MARK: - Properties
    private let genderView = GenderView()
//    private let emailViewModel = genderview()
    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = genderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bind()
    }
}
