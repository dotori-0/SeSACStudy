//
//  ChatAPIManager.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/12.
//

import Foundation
import Moya

struct ChatAPIManager {
    private init() { }
    
    private static let provider = MoyaProvider<ChatAPI>()
    
    /// 채팅 전송
    static func sendChat(to matchedUid: String, chat: String,
                         completion: @escaping (Result<Chat, Error>) -> Void) {
        provider.request(.sendChat(matchedUid: matchedUid, chat: chat)) { result in
            do {
                let response = try result.get()
                let chat = try response.map(Chat.self)
                print("💬 chat: \(chat)")
                completion(.success(chat))
            } catch {
                guard let definedError = definedError(error) else {
                    print("💬 처음 보는 status code")
                    return
                }
                
                print("💬 에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
    
    /// 채팅 목록 가져오기
    static func fetchChat(from matchedUid: String, lastChatDate: String,
                          completion: @escaping (Result<PayloadStruct, Error>) -> Void) {
        provider.request(.fetchChat(matchedUid: matchedUid, lastChatDate: lastChatDate)) { result in
            do {
//                print(result)
                let response = try result.get()
//                dump(response)
                print("response.statusCode: ", response.statusCode)
                print("response.response?.statusCode: ", response.response?.statusCode)
                
                let payload = try response.map(PayloadStruct.self)
                dump(payload)
                print("🥍 payload: \(payload)")
                print("🥍 payload.payload.count: \(payload.payload.count)")
                completion(.success(payload))
            } catch {
                guard let definedError = definedError(error) else {
                    print("🥍 처음 보는 status code")
                    return
                }
                
                print("🥍 에러: \(definedError)")
                completion(.failure(definedError))
            }
        }
    }
}

extension ChatAPIManager {
    /// 커스텀 에러로 변환하는 메서드
    private static func definedError(_ error: Error) -> Error? {
        guard let moyaError = error as? MoyaError else {
            print("😣 error -> MoyaError 변경 실패")
            return nil
        }
        
        guard let response = moyaError.response else {
            print("😣 moyaError -> Response 변경 실패")
            return nil
        }
        
        let statusCode = response.statusCode
        print("🐕 QueueAPIManager statusCode: \(statusCode)")
        
        if let definedError = QueueAPIError(rawValue: statusCode) {
            return definedError
        }
        
        let definedError: Error?
        definedError = QueueAPIError.SendChat(rawValue: statusCode)
        
        return definedError
    }
}
