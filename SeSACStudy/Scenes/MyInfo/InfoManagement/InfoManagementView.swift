//
//  InfoManagementView.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/01.
//

import UIKit

final class InfoManagementView: BaseView {
    // MARK: - Properties
    var collectionView: UICollectionView!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //    init(collectionView: UICollectionView!) {
    //        self.collectionView = collectionView
    //
    ////        collectionView.dataSource = self
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setHierarchy() {
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.register(GenderCollectionViewCell.self, forCellWithReuseIdentifier: GenderCollectionViewCell.reuseIdentifier)
        collectionView.register(StudyCollectionViewCell.self, forCellWithReuseIdentifier: StudyCollectionViewCell.reuseIdentifier)
        collectionView.register(SearchPermissionCollectionViewCell.self, forCellWithReuseIdentifier:
                                    SearchPermissionCollectionViewCell.reuseIdentifier)
        collectionView.register(AgeRangeCollectionViewCell.self, forCellWithReuseIdentifier:
                                    AgeRangeCollectionViewCell.reuseIdentifier)
        collectionView.register(DeleteAccountCollectionViewCell.self, forCellWithReuseIdentifier: DeleteAccountCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Design Methods
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = false
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

// MARK: - UICollectionViewDataSource
extension InfoManagementView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Row.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = Row(rawValue: indexPath.row) else { return UICollectionViewCell() }
        
        switch row {
            case .card:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier,
                                                                    for: indexPath) as? CardCollectionViewCell else {
                    print("Cannot find CardCollectionViewCell")
                    return UICollectionViewCell()
                }
                
                cell.setUsername(as: "김새싹")  // 서버에서 받아 온 유저네임으로 보여 주기
                return cell
            case .gender:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCollectionViewCell.reuseIdentifier,
                                                                    for: indexPath) as? GenderCollectionViewCell else {
                    print("Cannot find GenderCollectionViewCell")
                    return UICollectionViewCell()
                }
                cell.femaleView.isSelectedByUser = true  // 서버에서 받아 온 성별로 보여 주기
                return cell
            case .study:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudyCollectionViewCell.reuseIdentifier,
                                                                    for: indexPath) as? StudyCollectionViewCell else {
                    print("Cannot find StudyCollectionViewCell")
                    return UICollectionViewCell()
                }
                // 서버에서 받아 온 스터디로 보여 주기
                return cell
            case .searchPermission:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPermissionCollectionViewCell.reuseIdentifier,
                                                                    for: indexPath) as? SearchPermissionCollectionViewCell else {
                    print("Cannot find SearchPermissionCollectionViewCell")
                    return UICollectionViewCell()
                }
                
//                cell.toggleSwitch.isOn = // 서버에서 받아 온 허용 여부로 보여 주기
                return cell
            case .ageRange:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeRangeCollectionViewCell.reuseIdentifier,
                                                                    for: indexPath) as? AgeRangeCollectionViewCell else {
                    print("Cannot find AgeRangeCollectionViewCell")
                    return UICollectionViewCell()
                }
                // 서버에서 받아 온 최소 나이, 최대 나이로 보여 주기

                cell.slider.value = [18, 35]
                cell.updateAgeRangeLabel(minAge: cell.slider.minimumValue, maxAge: cell.slider.maximumValue)
                return cell
            case .deleteAccount:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeleteAccountCollectionViewCell.reuseIdentifier,
                                                                    for: indexPath) as? DeleteAccountCollectionViewCell else {
                    print("Cannot find DeleteAccountCollectionViewCell")
                    return UICollectionViewCell()
                }
                cell.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
                return cell
        }
    }
}

// MARK: - Action Methods
extension InfoManagementView {
    @objc private func deleteAccountButtonTapped() {
        
        print("☝🏻 회원탈퇴 버튼 탭")
        
        let alert = UIAlertController(title: String.MyInfo.InfoManagement.confirmAccountDeletion, message: String.MyInfo.InfoManagement.accountDeletionWarning, preferredStyle: .alert)
        let ok = UIAlertAction(title: String.Action.ok, style: .default) { _ in
            print("확인 탭")
            
        }
        
        let cancel = UIAlertAction(title: String.Action.cancel, style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
//        present(alert, animated: true)
        
        UserAPIManager.withdraw { result in
            switch result {
                case .success():
                    print("✅ 회원탈퇴 성공")
                case .failure(let error):
                    // Result<Void, Error> 이면 let error의 타입은 Error
                    // Result<Void, SeSACError> 이면 let error의 타입은 SeSACError
                    print("❎ 회원탈퇴 실패")
                    print("에러: \(error)")
            }
        }
    }
}

//extension InfoManagementView: GenderCellDelegate {
//    func didSelectGender(as gender: Gender, at cell: GenderCollectionViewCell) {
//        
//    }
//}


//extension InfoManagementView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print("🙊", #function)
//    }
//}

extension InfoManagementView {
    enum Row: Int, CaseIterable {
        case card
        case gender
        case study
        case searchPermission
        case ageRange
        case deleteAccount
    }
}
