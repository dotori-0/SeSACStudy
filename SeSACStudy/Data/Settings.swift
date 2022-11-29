//
//  Settings.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/29.
//

import Foundation

enum Settings: CaseIterable {
    case notice
    case FAQ
    case inquiries
    case notification
    case termsAndConditions
    
    var title: String {
        switch self {
            case .notice:
                return "공지사항"
            case .FAQ:
                return "자주 묻는 질문"
            case .inquiries:
                return "1:1 문의"
            case .notification:
                return "알림 설정"
            case .termsAndConditions:
                return "이용약관"
        }
    }
    
    struct SettingsItem: Hashable {
        let title: String
//        init(title: String) {
//            self.title = title
//        }
        private let identifier = UUID()
    }
    
    static var items: [SettingsItem] {
        createItems()
    }
    
    private static func createItems() -> [SettingsItem] {
        let settingsItems = Settings.allCases
            .map { SettingsItem(title: $0.title) }
        
        return settingsItems
    }
}
