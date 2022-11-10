//
//  ThirdViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

class ThirdViewController: BaseViewController {
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
        pageView.label.setText(with: String.Onboarding.third)
        pageView.imageView.image = Asset.Onboarding.onboardingImg3.image
    }
}
