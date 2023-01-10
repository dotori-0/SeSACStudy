//
//  MyQueueState.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/05.
//

import Foundation

struct MyQueueState: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String?
}
