//
//  Chat.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/12.
//

import Foundation
import RealmSwift

final class Chat: Object, Codable {
    let id, to, from, chat: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
