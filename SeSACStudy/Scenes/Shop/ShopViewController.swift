//
//  ShopViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit

final class ShopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showToast(message: "Shop")
    }

}
