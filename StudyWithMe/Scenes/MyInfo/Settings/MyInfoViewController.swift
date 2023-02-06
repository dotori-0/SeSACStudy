//
//  MyInfoViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit

final class MyInfoViewController: BaseViewController {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showToast(message: "My Info")
    }
    
    // MARK: - Setting Methods
    private func setNavigationBar() {
        title = String.MyInfo.myInfo
    }
    
    override func setHierarchy() {
        myInfoView.collectionView.delegate = self
    }
}

extension MyInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = MyInfoView.Section(rawValue: indexPath.section) else {
            print("Cannot find section in didSelectItemAt")
            return
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if section == .settings {
//            makeToast(String.MyInfo.workInProgress, duration: 0.5, position: .center)
            showToast(message: String.MyInfo.workInProgress)
        } else {
            // 정보 관리 화면으로 전환
//            makeToast("정보 관리 화면으로 전환", duration: 0.5, position: .center)
            showToast(message: "정보 관리 화면으로 전환")
            transition(to: InfoManagementViewController())
        }
    }
}
