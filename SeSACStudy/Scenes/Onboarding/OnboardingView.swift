//
//  OnboardingView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class OnboardingView: BaseView {
    // MARK: - Properties
    private let startButton = GlobalButton(title: .Onboarding.start)
    private let pageView = UIView()//.then { $0.backgroundColor = .systemBrown }
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    let subViewControllers = [FirstViewController(), SecondViewController(), ThirdViewController()]
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setPageViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {
        setButtonColor()
    }
    
    override func setHierarchy() {
        [pageView, startButton].forEach {
            addSubview($0)
        }
        
        pageView.addSubview(pageViewController.view)
    }
    
    override func setConstraints() {
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
        
        pageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(64)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(startButton.snp.top).offset(-42)
        }
        
        pageViewController.view.frame = pageView.frame
    }
    
    private func setPageViewController() {
        guard let firstVC = subViewControllers.first else { return }
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        setPageControl()
    }
    
    private func setPageControl() {
        UIPageControl.appearance().currentPageIndicatorTintColor = Asset.Colors.BlackWhite.black.color
        UIPageControl.appearance().pageIndicatorTintColor = Asset.Colors.Grayscale.gray5.color
    }
    
    // MARK: - Design Methods
    private func setButtonColor() {
        startButton.changeButtonColorToGreen()
    }
}
