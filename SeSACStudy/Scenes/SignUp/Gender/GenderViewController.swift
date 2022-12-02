//
//  GenderViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/22.
//

import UIKit
import RxSwift

final class GenderViewController: BaseViewController {
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
                    vc.signUpAndPush()
                } else {
                    print("성별 선택 X")
                    vc.showToast(message: String.Gender.selectGender)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func signUpAndPush() {
        print(#function)
        genderViewModel.signUp()
        
        genderViewModel.account
            .subscribe(with: self) { vc, _ in
                // 성공 응답 → 홈 화면 전환
                print("account onNext")
                UserDefaults.isLoggedIn = true
                vc.showToast(message: String.Gender.signUpSucceeded) { [weak self] _ in
//                    self?.transition(to: TabBarController())
                    self?.setRootVCToTabBarController()
                }
            } onError: { vc, error in  // 넘겨주는 쪽(onError)이 SeSACError여도 받는 쪽에서 그냥 error인 이유 및 해결 방법 ❔
                guard let error = error as? SeSACError else {
                    print("SeSACError로 변환 실패")
                    return
                }
                
                print(error)
                print(error.errorDescription)
                
                switch error {
                    case .existingUser:
                        // 가입 시도 시 이미 가입한 유저의 경우 토스트 띄우고 홈 화면으로 전환
                        vc.showToast(message: String.Gender.existingUser) { [weak self] _ in
        //                    self?.transition(to: TabBarController())
                            self?.setRootVCToTabBarController()
                        }
                    case .unavailableNickname:
                        NicknameViewController.isFromGenderVC = true
                        vc.navigationController?.popToViewController(ofClass: NicknameViewController.self)
                    case .firebaseTokenError:
                        vc.refreshIDToken {                            
                            vc.signUpAndPush()
                        }
                        // 이렇게 가입 시 나오지 않을 에러(406)는 어떻게 처리?
                        // 애초부터 모든 API의 에러를 statusCode가 겹친다는 이유로 하나로만 만드는 것이 적절하지 않은 방법인지? ❔
//                    case .unregisteredUser:
//                        <#code#>
                    case .serverError:
                        guard let errorDescription = error.errorDescription else { return }
                        vc.showToast(message: errorDescription)
                    case .clientError:
                        print("API 요청시 Header와 RequestBody에 값을 빠트리지 않고 전송했는지 확인")
                    default:
                        print("default")
                }
            }
            .disposed(by: disposeBag)

    }
}
