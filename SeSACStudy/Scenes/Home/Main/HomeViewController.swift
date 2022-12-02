//
//  MainViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/25.
//

import UIKit
import NMapsMap

final class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .systemYellow

        print(self)
        
        
        let naverMapView = NMFNaverMapView()
        view.addSubview(naverMapView)
        
        naverMapView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalToSuperview()
        }
        
        
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        let appearance = UINavigationBarAppearance()

//        appearance.backgroundColor = .systemPink
        appearance.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        appearance.backButtonAppearance = backButtonAppearance
        appearance.setBackIndicatorImage(Asset.NavigationBar.arrow.image,
                                         transitionMaskImage: Asset.NavigationBar.arrow.image)

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        hideNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        showToast(message: "Main")
        
//        hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.isHidden = true
        print("NC: \(navigationController)")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.scrollEdgeAppearance = nil
        navigationController?.navigationBar.compactAppearance = nil
    }
}
