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
    private let genderViewModel = GenderViewModel()
    private let disposeBag = DisposeBag()
    private var selectedGender: Gender?

    // MARK: - Life Cycle
    override func loadView() {
        view = genderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        genderView.maleSelectionView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                print("male tapped")
                print("기존: \(vc.genderView.maleSelectionView.isSelectedByUser)")
                vc.genderView.maleSelectionView.isSelectedByUser.toggle()
                vc.genderView.femaleSelectionView.isSelectedByUser = false
                print("변경 후: \(vc.genderView.maleSelectionView.isSelectedByUser)")
                vc.selectedGender = .male
            }
            .disposed(by: disposeBag)
        
        genderView.femaleSelectionView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                vc.genderView.femaleSelectionView.isSelectedByUser = true
                vc.genderView.maleSelectionView.isSelectedByUser = false
                vc.selectedGender = .female
            }
            .disposed(by: disposeBag)
    }
    
    private func signUpAndPush() {
        genderViewModel.signUp()
        
        genderViewModel.account
            .subscribe(with: self) { vc, _ in
                // 성공 응답 → 홈 화면 전환
                
            } onError: { vc, error in
                
            }
            .disposed(by: disposeBag)

    }
}
