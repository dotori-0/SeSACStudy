//
//  LogInViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/14.
//

import UIKit

class LogInViewController: BaseViewController {
    // MARK: - Properties
    private let logInView = LogInView()
//    private let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func loadView() {
        view = logInView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
