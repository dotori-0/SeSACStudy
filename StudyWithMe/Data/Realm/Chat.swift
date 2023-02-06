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

    convenience init(id: String, to: String, from: String, chat: String, createdAt: String) {
        self.init()
        self.id = id
        self.to = to
        self.from = from
        self.chat = chat
        self.createdAt = createdAt
    }
}


// MARK: - Payload
struct PayloadStruct: Codable {
    let payload: [PayloadElement]
}

// MARK: - PayloadElement
struct PayloadElement: Codable {
    let id, to, from, chat: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
