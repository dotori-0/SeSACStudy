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
}


