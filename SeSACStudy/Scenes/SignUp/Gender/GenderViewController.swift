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
//    private var selectedGender: Gender?

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
//                vc.selectedGender = .male
                vc.genderViewModel.gender.onNext(.male)
            }
            .disposed(by: disposeBag)
        
        genderView.femaleSelectionView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                vc.genderView.femaleSelectionView.isSelectedByUser = true
                vc.genderView.maleSelectionView.isSelectedByUser = false
//                vc.selectedGender = .female
                vc.genderViewModel.gender.onNext(.female)
            }
            .disposed(by: disposeBag)
        
        genderViewModel.gender
            .withUnretained(self)
            .bind { (vc, gender) in
                if gender != nil {
                    vc.genderView.button.isActivated = true
                } else {
                    vc.genderView.button.isActivated = false
                }
            }
            .disposed(by: disposeBag)
        
        genderView.button.rx.tap
            .asDriver()
            .drive(with: self) { vc, _ in
                if let gender = try? vc.genderViewModel.gender.value() {
                    // BehaviorSubject일 때는 try와 .value(), BehaviorRelay일 때는 그냥 .value로 하는게 맞는지? ❔
                    // 성공 응답 → 홈 화면 전환
                    // 금지된 단어로 닉네임 사용한 경우(code 202) → 닉네임 입력 화면으로 전환
                    print("성별 선택 O")
                    NewUser.shared.gender = gender.rawValue
                } else {
                    print("성별 선택 X")
                    vc.showToast(message: String.Gender.selectGender)
                }
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
