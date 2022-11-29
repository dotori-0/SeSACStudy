//
//  MyInfoView.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/28.
//

import UIKit

final class MyInfoView: BaseView, CellRegistrationType {
    // MARK: - Properties
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    var dataSource: UICollectionViewDiffableDataSource<Section, Settings.SettingsItem>!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureDataSource()
        applyInitialSnapshots()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    override func setUI() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    override func setHierarchy() {
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout  // UICollectionViewCompositionalLayout
    }
    
    private func createAccessories() -> [UICellAccessory] {
        let arrow = UIImageView(image: Asset.MyInfo.Settings.moreArrow.image)
        let configuration = UICellAccessory.CustomViewConfiguration(customView: arrow,
                                                                    placement: .trailing())
        let accessory = UICellAccessory.customView(configuration: configuration)
        return [accessory]
    }
    
    private func createUsernameCellRegistration() -> StringCellRegistration {
        let cellRegistration = StringCellRegistration { [weak self] cell, indexPath, itemIdentifier in
            guard let self = self else { return }
//            var content = UIListContentConfiguration.cell()
//            var content = UIListContentConfiguration.valueCell()
            var content = cell.defaultContentConfiguration()  // 위 두 가지와 차이점이 뭔지? ❔
            content.image = Asset.MyInfo.Settings.profileImg.image
            content.attributedText = "김새싹".addAttributes(font: .Title1_M16,
                                                         textColor: Asset.Colors.BlackWhite.black.color)
            cell.accessories = self.createAccessories()
            cell.contentConfiguration = content
        }
        
        return cellRegistration
    }
    
//    private
    
    private func configureDataSource() {
        let usernameCellRegistration = createUsernameCellRegistration()
  
        // 방법 1
        dataSource = UICollectionViewDiffableDataSource<Section, Settings.SettingsItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
  
        // 방법 2
//        dataSource = UICollectionViewDiffableDataSource<Section, Settings.SettingsItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
  
        // 방법 3
//            dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
//                (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
                print("Cannot find section in MyInfoView")
                return UICollectionViewCell()
            }

            switch section {
                case .user:
                    return collectionView.dequeueConfiguredReusableCell(using: usernameCellRegistration, for: indexPath, item: "김새싹")
                case .settings:
                    return collectionView.dequeueConfiguredReusableCell(using: usernameCellRegistration, for: indexPath, item: "김새싹2")
            }
        }
    }
    
    private func applyInitialSnapshots() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Settings.SettingsItem>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot)
//        dataSource.apply(snapshot, animatingDifferences: false)  // default가 true
        
        let usernameItems = [Settings.SettingsItem(title: "김새싹")]
        var usernameSnapshot = NSDiffableDataSourceSectionSnapshot<Settings.SettingsItem>()
        usernameSnapshot.append(usernameItems)
        dataSource.apply(usernameSnapshot, to: .user)
    }
}

extension MyInfoView {
    enum Section: Int, CaseIterable {
        case user
        case settings
    }
}
