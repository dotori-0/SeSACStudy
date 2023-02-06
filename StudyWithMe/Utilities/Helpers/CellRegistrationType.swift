//
//  CellRegistrationType.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/29.
//

import UIKit

protocol CellRegistrationType {
    typealias StringCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String>
    typealias SettingsItemCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Settings.SettingsItem>
}
