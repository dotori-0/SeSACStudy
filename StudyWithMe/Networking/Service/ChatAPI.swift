//
//  ChatAPI.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/12.
//

import Foundation
import Moya

enum ChatAPI {
    case sendChat(matchedUid: String, chat: String)
    case fetchChat(matchedUid: String, lastChatDate: String)
}

extension ChatAPI: TargetType {
    var baseURL: URL {
        return URL(string: APIURL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .sendChat(matchedUid: let matchedUid, chat: _):
                return APIURL.v1Chat.endpoint(matchedUid: matchedUid)
            case .fetchChat(matchedUid: let matchedUid, lastChatDate: _):
                return APIURL.v1Chat.endpoint(matchedUid: matchedUid)
//                return "http://api.sesac.co.kr:1210/v1/chat/eT7g1xuSfDPfGl83Id23NkvgJvx1?lastchatDate=2000-01-01T00:00:00.000Z"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .sendChat:
                return .post
            case .fetchChat:
                return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
            case .sendChat(_, let chat):
                let parameters: [String: Any] = ["chat": chat]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
            case .fetchChat(_, let lastChatDate):
                let parameters: [String: Any] = ["lastchatDate": lastChatDate]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
//                return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["idtoken": UserDefaults.idToken,
                "Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var validationType: ValidationType {
        return .customCodes([200])
    }
}
