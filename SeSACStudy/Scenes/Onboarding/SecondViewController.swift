//
//  SecondViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

final class SecondViewController: BaseViewController {
    // MARK: - Properties
    let pageView = PageView()

    // MARK: - Life Cycle
    override func loadView() {
        view = pageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Setting Methods
    override func setUI() {
        pageView.label.setText(with: String.Onboarding.second, highlight: String.Onboarding.secondHighlight)
        pageView.imageView.image = Asset.Onboarding.onboardingImg2.image
    }
}
