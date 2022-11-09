//
//  BaseViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

import RxSwift
import RxCocoa
import Toast

class BaseViewController: UIViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Setting Methods
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setHierarchy() { }
    
    func setConstraints() { }
}
