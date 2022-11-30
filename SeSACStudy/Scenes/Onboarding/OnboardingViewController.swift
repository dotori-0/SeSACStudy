//
//  OnboardingViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit
import RxCocoa
import RxSwift

final class OnboardingViewController: BaseViewController {
    // MARK: - Properties
    private let onboardingView = OnboardingView()
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        bind()
    }
    
    // MARK: - Setting Methods
    private func setNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = nil
    }
    
    override func setHierarchy() {
        addChild(onboardingView.pageViewController)
        onboardingView.pageViewController.dataSource = self
    }
    
    private func bind() {
        onboardingView.startButton.rx.tap
            .asDriver()
            .drive(with: self, onNext: { vc, _ in
                vc.transition(to: VerificationViewController())
                UserDefaults.isExistingUser = true
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? BaseViewController else { return nil }
        guard let currentIndex = onboardingView.subViewControllers.firstIndex(of: currentVC) else {
            print("no currentIndex", #function)
            return nil
        }
        
        let previousIndex = currentIndex - 1
        print("현재: \(currentIndex), 이전: \(previousIndex)")
        
        return previousIndex < 0 ? nil : onboardingView.subViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? BaseViewController else { return nil }
        guard let currentIndex = onboardingView.subViewControllers.firstIndex(of: currentVC) else {
            print("no currentIndex", #function)
            return nil
        }
        
        let nextIndex = currentIndex + 1
        print("현재: \(currentIndex), 다음: \(nextIndex)")
        
        return nextIndex >= onboardingView.subViewControllers.count ? nil : onboardingView.subViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardingView.subViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
