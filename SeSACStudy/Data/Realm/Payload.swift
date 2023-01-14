//
//  Payload.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/12.
//

import Foundation
import RealmSwift

final class Payload: Object, Codable {
    @Persisted var payload: List<Chat>

//    convenience init(payload: List<Chat>) {
//        self.init()
//        self.payload = payload
//    }
}
//
//extension List: Decodable where Element: Decodable {
//    public convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.singleValueContainer()
//        let decodedElements = try container.decode([Element].self)
//        self.append(objectsIn: decodedElements)
//    }
//}
//
//extension List: Encodable where Element: Encodable {
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(self.map { $0 })
//    }
//}


