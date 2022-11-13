//
//  NetworkMonitor.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/12.
//

import Foundation
import Network

final class NetworkMonitor {
    private init() { }
    
    static let shared = NetworkMonitor()
    
    let monitor = NWPathMonitor()
    
    func startMonitoring(noConnectionHandler: @escaping () -> Void) {
        monitor.start(queue: DispatchQueue.global())
        print("🛰 startMonitoring")
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                print("인터넷 연결 ⭕️")
//                self?.stopMonitoring()
            } else {
                print("인터넷 연결 ❌")
                DispatchQueue.main.async { // [weak self] in
                    noConnectionHandler()
//                    self?.stopMonitoring()

                }
//                self?.startMonitoring(noConnectionHandler: noConnectionHandler)
//                print("Started Monitoring Again")
            }
        }
    }
    
    func stopMonitoring() {
        print("🛸 Stopped Monitoring")
        monitor.cancel()
    }
}
