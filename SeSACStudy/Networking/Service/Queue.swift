//
//  Queue.swift
//  SeSACStudy
//
//  Created by SC on 2022/12/07.
//

import Foundation
import Moya

enum Queue {
    case find(latitude: Double, longitude: Double, studyList: [String])
    case stopFinding
    case fetchNearbyUsers(latitude: Double, longitude: Double)
    case myQueueState
    case requestStudy(otheruid: String)
    case acceptStudy(otheruid: String)
    case cancelStudy(otheruid: String)
    case rate(otheruid: String, reputation: [Int], comment: String)
}

extension Queue: TargetType {
    var baseURL: URL {
        return URL(string: APIURL.baseURL)!
    }
    
    var path: String {
        switch self {
            case .find:
                return APIURL.v1Queue.find.endpoint
            case .stopFinding:
                return APIURL.v1Queue.stopFinding.endpoint
            case .fetchNearbyUsers:
                return APIURL.v1Queue.fetchNearbyUsers.endpoint
            case .myQueueState:
                return APIURL.v1Queue.myQueueState.endpoint
            case .requestStudy:
                return APIURL.v1Queue.requestStudy.endpoint
            case .acceptStudy:
                return APIURL.v1Queue.acceptStudy.endpoint
            case .cancelStudy:
                return APIURL.v1Queue.cancelStudy.endpoint
            case .rate(let otheruid, _, _):
                return APIURL.v1Queue.rate.endpoint + "/\(otheruid)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .find:
                return .post
            case .stopFinding:
                return .delete
            case .fetchNearbyUsers:
                return .post
            case .myQueueState:
                return .get
            case .requestStudy:
                return .post
            case .acceptStudy:
                return .post
            case .cancelStudy:
                return .post
            case .rate:
                return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
            case .find(let latitude, let longitude, let studyList):
                let parameters: [String : Any] = ["lat": latitude,
                                                  "long": longitude,
                                                  "studylist": studyList]
                return .requestParameters(parameters: parameters,
                                          encoding: URLEncoding.httpBody)
            case .stopFinding:
                return .requestPlain
            case .fetchNearbyUsers(let latitude, let longitude):
                let parameters: [String : Any] = ["lat": latitude,
                                                  "long": longitude]
                return .requestParameters(parameters: parameters,
                                          encoding: URLEncoding.httpBody)
            case .myQueueState:
                return .requestPlain
            case .requestStudy(let otheruid),
                    .acceptStudy(let otheruid),
                    .cancelStudy(let otheruid):
                let parameters: [String : Any] = ["otheruid": otheruid]
                return .requestParameters(parameters: parameters,
                                          encoding: URLEncoding.httpBody)
//            case .acceptStudy(let otheruid):
//                <#code#>
//            case .cancelStudy(let otheruid):
//                <#code#>
            case .rate(let otheruid, let reputation, let comment):
                let parameters: [String : Any] = ["otheruid": otheruid,
                                                  "reputation": reputation,
                                                  "comment": comment]
                return .requestParameters(parameters: parameters,
                                          encoding: URLEncoding.httpBody)
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
