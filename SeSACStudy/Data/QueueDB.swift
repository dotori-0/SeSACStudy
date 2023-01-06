//
//  QueueDB.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/06.
//

import Foundation

// MARK: - QueueDB
struct QueueDB: Codable {
    let fromQueueDB, fromQueueDBRequested: [NearbyUser]
    let fromRecommend: [String]
}

// MARK: - NearbyUser
struct NearbyUser: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let studylist, reviews: [String]
    let gender, type, sesac, background: Int
}
