//
//  InfoManagementViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

class InfoManagementViewController: BaseViewController {
    // MARK: - Properties
    let infoManagementView = InfoManagementView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = infoManagementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        toast()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toast()
    }
    
    private func toast() {
        print(#function)
        showToast(message: "정보 관리")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
