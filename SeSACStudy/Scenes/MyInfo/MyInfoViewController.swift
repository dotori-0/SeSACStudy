//
//  MyInfoViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit

class MyInfoViewController: BaseViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showToast(message: "My Info")
    }
}
