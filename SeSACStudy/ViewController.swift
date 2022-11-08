//
//  ViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for family in UIFont.familyNames {
            print("====\(family)====")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
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
