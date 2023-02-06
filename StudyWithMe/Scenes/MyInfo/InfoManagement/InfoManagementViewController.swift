//
//  InfoManagementViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

final class InfoManagementViewController: BaseViewController {
    // MARK: - Properties
    let infoManagementView = InfoManagementView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = infoManagementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        toast()
        setNavigationBar()
        
        print("🪙 \(UserDefaults.idToken)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toast()
    }
    
    private func toast() {
        print(#function)
        showToast(message: "정보 관리")
    }

    // MARK: - Setting Methods
    private func setNavigationBar() {
        title = String.MyInfo.InfoManagement.infoManagement
    }
}

extension InfoManagementViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
