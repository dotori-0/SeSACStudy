//
//  Chat.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/12.
//

import Foundation
import RealmSwift

final class Chat: Object, Codable {
    @Persisted var id: String
    @Persisted var to: String
    @Persisted var from: String
    @Persisted var chat: String
    @Persisted var createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
