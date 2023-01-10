//
//  Settings.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/29.
//

import UIKit

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
    
    var image: UIImage {
        switch self {
            case .notice:
                return Asset.MyInfo.Settings.notice.image
            case .FAQ:
                return Asset.MyInfo.Settings.faq.image
            case .inquiries:
                return Asset.MyInfo.Settings.qna.image
            case .notification:
                return Asset.MyInfo.Settings.settingAlarm.image
            case .termsAndConditions:
                return Asset.MyInfo.Settings.permit.image
        }
    }
    
    struct SettingsItem: Hashable {
        let title: String
        let image: UIImage?
        init(title: String, image: UIImage? = nil) {
            self.title = title
            self.image = image
        }
        private let identifier = UUID()
    }
    
    static var items: [SettingsItem] {
        createItems()
    }
    
    private static func createItems() -> [SettingsItem] {
        let settingsItems = Settings.allCases
            .map { SettingsItem(title: $0.title, image: $0.image) }
        
        return settingsItems
    }
}
