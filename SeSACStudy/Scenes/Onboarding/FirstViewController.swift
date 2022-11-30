//
//  FirstViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

final class FirstViewController: BaseViewController {
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
        pageView.label.setText(with: String.Onboarding.first, highlight: String.Onboarding.firstHighlight)
        pageView.imageView.image = Asset.Onboarding.onboardingImg1.image
    }
}
