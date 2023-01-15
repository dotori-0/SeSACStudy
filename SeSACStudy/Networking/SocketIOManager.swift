//
//  SocketIOManager.swift
//  SeSACStudy
//
//  Created by SC on 2023/01/15.
//

import Foundation
import SocketIO

class SocketIOManager {
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private init() {
        manager = SocketManager(socketURL: URL(string: APIURL.baseURL)!, config: [
            .log(true),  // 하나하나 다 출력
            .forceWebsockets(true)
        ])

        
        socket = manager.defaultSocket  // http://api.sesac.co.kr:2022/
        
        
        // 연결
//        socket.on(clientEvent: .connect) { data, ack in
//            print("SOCKET IS CONNECTED", data, ack)
//        }
        
        // 소켓 연결 메서드
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            print("Socket is connected", data, ack)
            self?.socket.emit("changesocketid", UserDefaults.id)
        }
        
        // 연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        // 이벤트 수신
        socket.on("chat") { dataArray, ack in
            print("CHAT RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chatID = data["_id"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            let from = data["from"] as! String
            let to = data["to"] as! String
            
            
            print("CHECK >>>", from, to, chat, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("receivedChat"),
                                            object: self,
                                            userInfo: ["chatID": chatID,
                                                       "chat": chat,
                                                       "createdAt": createdAt,
                                                       "from": from,
                                                       "to": to])
        }
    }
    
    func establishConnection() {
        socket.connect()  // 연결하는 메서드
    }
    
    func closeConnection() {
        socket.disconnect()  // 연결 해제하는 메서드
    }
}
