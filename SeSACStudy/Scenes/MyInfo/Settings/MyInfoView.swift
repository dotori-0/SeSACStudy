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
        collectionView.delegate = self
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .user {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -1, bottom: 5, trailing: -1)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

//                let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
//                section = .list(using: configuration, layoutEnvironment: layoutEnvironment)
            } else if sectionKind == .settings {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -1, bottom: 5, trailing: -1)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.18))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
            } else {
                fatalError("Unknown section!")
            }


            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
//        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        return layout  // UICollectionViewCompositionalLayout
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
    
//            var background = UIBackgroundConfiguration.listPlainCell()
//            background.strokeColor = .systemPink
//            background.strokeWidth = 1.0 / cell.traitCollection.displayScale
//            cell.backgroundConfiguration = background
        }
        
        return cellRegistration
    }
    
    private func createSettingCellRegistration() -> SettingsItemCellRegistration {
        let cellRegistration = SettingsItemCellRegistration { cell, indexPath, item in
            var content = cell.defaultContentConfiguration()
            content.image = item.image
            content.attributedText = item.title.addAttributes(font: .Title2_R16,
                                                              textColor: Asset.Colors.BlackWhite.black.color)
            cell.contentConfiguration = content
            
            
//            var background = UIBackgroundConfiguration.listPlainCell()
//            background.strokeColor = .systemGreen
//            background.strokeWidth = 1.0 / cell.traitCollection.displayScale
//            cell.backgroundConfiguration = background
        }
        
        return cellRegistration
    }
    
    private func configureDataSource() {
        let usernameCellRegistration = createUsernameCellRegistration()
        let settingCellRegistration = createSettingCellRegistration()
  
        // 방법 1
        dataSource = UICollectionViewDiffableDataSource<Section, Settings.SettingsItem>(collectionView: collectionView) { collectionView, indexPath, item in
  
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
                    return collectionView.dequeueConfiguredReusableCell(using: usernameCellRegistration, for: indexPath, item: item.title)
                case .settings:
                    return collectionView.dequeueConfiguredReusableCell(using: settingCellRegistration, for: indexPath, item: item)
            }
        }
    }
    
    private func applyInitialSnapshots() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Settings.SettingsItem>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot)
//        dataSource.apply(snapshot, animatingDifferences: false)  // default가 true
        
//        let usernameItems = ["김새싹"]
//        var usernameSnapshot = NSDiffableDataSourceSectionSnapshot<String>()
        let usernameItems = [Settings.SettingsItem(title: "김새싹")]
        var usernameSnapshot = NSDiffableDataSourceSectionSnapshot<Settings.SettingsItem>()
        usernameSnapshot.append(usernameItems)
        dataSource.apply(usernameSnapshot, to: .user)
        
        let settingItems = Settings.items
        var settingSnapshot = NSDiffableDataSourceSectionSnapshot<Settings.SettingsItem>()
        settingSnapshot.append(settingItems)
        dataSource.apply(settingSnapshot, to: .settings)
    }
}

extension MyInfoView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            print("Cannot find section in didSelectItemAt")
            return
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if section == .settings {
            makeToast(String.MyInfo.workInProgress, duration: 0.5, position: .center)
        } else {
            // 정보 관리 화면으로 전환
            makeToast("정보 관리 화면으로 전환", duration: 0.5, position: .center)
        }
    }
}

extension MyInfoView {
    enum Section: Int, CaseIterable {
        case user
        case settings
    }
}
