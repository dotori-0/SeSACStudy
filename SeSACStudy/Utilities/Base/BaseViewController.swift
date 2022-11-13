//
//  BaseViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/10.
//

import UIKit

import RxSwift
import RxCocoa
import Toast

class BaseViewController: UIViewController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkNetwork()
        setUI()
        setHierarchy()
        setConstraints()
    }
    
    deinit {
        NetworkMonitor.shared.stopMonitoring()
    }
    
    // MARK: - Setting Methods
    private func checkNetwork() {
        NetworkMonitor.shared.startMonitoring { [weak self] in
            print("🚨 alert")
//            NetworkMonitor.shared.stopMonitoring()  // stopMonitoring을 어디에 넣어야 할지.. ❔
            
            // without handler
//            self?.alert(title: String.NetworkError.networkError,
//                        message: String.NetworkError.networkErrorMessage)
            
            // with handler
            self?.alert(title: String.NetworkError.networkError,
                        message: String.NetworkError.networkErrorMessage) { [weak self] _ in
//                NetworkMonitor.shared.stopMonitoring()  // stopMonitoring을 어디에 넣어야 할지.. ❔
                self?.checkNetwork()
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setHierarchy() { }
    
    func setConstraints() { }
}
