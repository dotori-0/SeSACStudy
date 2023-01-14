//
//  ChatRepository.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/12.
//

import Foundation
import RealmSwift

protocol Repository: HandlerType {
    associatedtype T: RealmCollectionValue
//    typealias Handler = () -> Void
    
    func fetch() -> Results<T>
    func add(_ items: List<T>, completionHandler: @escaping Handler, errorHandler: @escaping Handler)
}

final class ChatRepository: Repository {
    let realm = try! Realm()
    
    func fetch() -> Results<Chat> {
        return realm.objects(Chat.self)
    }
    
    func add(_ items: List<Chat>, completionHandler: @escaping Handler, errorHandler: @escaping Handler) {
        do {
            try realm.write {
                realm.add(items)  // Chat 하나씩 넣지 않고 List<Chat>으로 한꺼번에 넣어도 들어가는지 확인하기!
//                completionHandler()  // 여기에서 해야 하는지? -> 어디서 하든 상관은 없지만 명확히 구분하기 위해 realm.write 구문 밖에서 실행
            }
            completionHandler()
        } catch  {
            print(error)
            errorHandler()
        }
    }
    
    func newestChatDateInDB() -> String? {
        guard let  newestChatInDB = realm.objects(Chat.self).sorted(byKeyPath: RealmKey.createdAt, ascending: false).first else {
            print("최신 채팅 찾기 실패")
            return nil
        }
        
        let newestChatDateInDB = newestChatInDB.createdAt
        return newestChatDateInDB
    }
}
