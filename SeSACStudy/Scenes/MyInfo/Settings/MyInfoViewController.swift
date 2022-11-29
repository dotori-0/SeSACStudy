//
//  MyInfoViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit

class MyInfoViewController: BaseViewController {
    // MARK: - Properties
    let myInfoView = MyInfoView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = myInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
    
    private func setNavigationBar() {
        title = String.MyInfo.myInfo
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showToast(message: "My Info")
    }
}
