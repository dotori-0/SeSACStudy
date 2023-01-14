//
//  ChatsViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit
import Alamofire
import RealmSwift

final class ChatsViewController: BaseViewController, HandlerType {
    // MARK: - Properties
    private let chatsView = ChatsView()
    private let repository = ChatRepository()
    private var dummy: [String] = []
    private var matchedNickname: String!
    private var matchedUid: String!
    private var chats: Results<Chat>! {
        didSet {
            print("Chats Changed")
        }
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = chatsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("🐰 Realm is located at:", repository.realm.configuration.fileURL!)

        setNavigationBar()
        setActions()
//        configureDummyChat()
        configureTableView()
        fetchQueueState()
//        fetchChatsAF(from: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showToast(message: "Chats")
    }
    
    // MARK: - Setting Methods
    private func setNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = AppAppearance.navigationBarAppearance
    }
    
    private func setNavigationTitle(as title: String) {
        self.title = title
    }
    
    
    private func setActions() {
        chatsView.sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc private func sendButtonClicked() {
        print("전송 버튼 탭")
        sendChat()
    }
    
    // MARK: - Realm Methods
    private func fetchChatsFromDB(isAfterFetchingFromServer: Bool, completion: Handler? = nil) {
        chats = repository.fetch()
        
        print("채팅 갯수:", chats.count)
        print("Is DB empty?: \(chats.isEmpty)")
        
        if isAfterFetchingFromServer {
            completion?()
            return
        }
        
        if chats.isEmpty {
//            fetchChats(from: String.Chats.lastChatDateIfChatsEmpty)
            fetchChatsAF(from: String.Chats.lastChatDateIfChatsEmpty)
        } else {
            guard let newestChatDateInDB = repository.newestChatDateInDB() else {
                print("최신 채팅 찾기 실패!")
                return
            }
//            fetchChats(from: newestChatDateInDB)
            fetchChatsAF(from: newestChatDateInDB)
        }
    }
}

// MARK: -  UITableViewDataSource
extension ChatsViewController: UITableViewDataSource {
    private func configureTableView() {
        chatsView.tableView.delegate = self
        chatsView.tableView.dataSource = self
        chatsView.tableView.allowsSelection = false
        chatsView.tableView.separatorStyle = .none
        chatsView.tableView.rowHeight = UITableView.automaticDimension
//        chatsView.tableView.rowHeight = 100
        
        // Dynamic Header Height 방법 1 (헤더와 셀 사이에 틈 생김)
//        chatsView.tableView.tableHeaderView = MatchedHeaderView()
//        chatsView.tableView.sectionHeaderHeight = UITableView.automaticDimension
//        chatsView.tableView.estimatedSectionHeaderHeight = 100
//        chatsView.tableView.sectionHeaderTopPadding = .zero
//        if #available(iOS 15.0, *) {  // 해도 틈 안 사라짐
//            chatsView.tableView.sectionHeaderTopPadding = .zero
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dummy.count
        if chats == nil { return Int.zero }
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("🦉")
//        if chats.isEmpty { return UITableViewCell() }
        
//        let chat = dummy[indexPath.row]
        let chat = chats[indexPath.row]
        print("\([indexPath.row]) chat.from: \(chat.from)")
        print("\([indexPath.row]) matchedUid: \(matchedUid)")
        
//        if indexPath.row.isMultiple(of: 2) {
        if chat.from == matchedUid {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ReceivedTableViewCell else {
                return UITableViewCell()
            }
//            cell.chatLabel.text = chat
            cell.chatLabel.text = chat.chat
            cell.timeLabel.text = "몇 시"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? SentTableViewCell else {
                return UITableViewCell()
            }
            
//            cell.chatLabel.text = chat
            cell.chatLabel.text = chat.chat
            cell.timeLabel.text = "몇 시"
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ChatsViewController: UITableViewDelegate {
// Dynamic Header Height 방법 1 (헤더와 셀 사이에 틈 생김)
//    chatsView.tableView.tableHeaderView = MatchedHeaderView()
//    chatsView.tableView.sectionHeaderHeight = UITableView.automaticDimension
//    chatsView.tableView.estimatedSectionHeaderHeight = 100
    
// Dynamic Header Height 방법 2 (헤더와 셀 사이에 틈 X)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MatchedHeaderView()
        headerView.showMatchedNickname(matchedNickname ?? "")
        return headerView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func scrollToBottom() {
        chatsView.tableView.scrollToRow(at: IndexPath(row: chats.count - 1, section: 0),
                                        at: .bottom,
                                        animated: false)
    }
}

extension ChatsViewController {
    private func configureDummyChat() {
        dummy = ["안녕하세요", "반갑습니다", "별명이 왜 모찌인가요?", "세상에서\n모찌가 젤\n맛있더라구요", "아...", "안녕하세요 알고리즘 스터디는 언제 하실 생각이세요?", "안녕하세요! 저 평일은 저녁 8시에 꾸준히 하는데 7시부터 해도 괜찮아요", "안녕하세요! 저 평일은 저녁 8시에 꾸준히 하는데 7시부터 해도 괜찮아요 안녕하세요! 저 평일은 저녁 8시에 꾸준히 하는데 7시부터 해도 괜찮아요"]
    }
}

// MARK: - Networking Methods
extension ChatsViewController {
    private func fetchQueueState() {
        print(#function)
        QueueAPIManager.myQueueState { [weak self] result in
            switch result {
                case .success(let myQueueState):
                    print("⭐️ \(myQueueState)")
                    if let matchedNick = myQueueState.matchedNick, let matchedUid = myQueueState.matchedUid {
                        self?.setNavigationTitle(as: matchedNick)
                        self?.matchedNickname = matchedNick
                        self?.matchedUid = matchedUid
//                        self?.fetchChats()
                        self?.fetchChatsFromDB(isAfterFetchingFromServer: false)
                    } else {
                        self?.alert(title: String.Chats.notMatched, message: String.Chats.matchingNeeded)
                    }
                case .failure(let error):
                    print(error)
                    // 에러를 커스텀 에러로 바꾼 후 처리하기
                    if let definedError = error as? QueueAPIError {
                        print("🧸 QueueAPIError: \(definedError)")
                        if definedError == .firebaseTokenError {
                            self?.refreshIDToken {
                                self?.fetchQueueState()
                            }
                        }
                        return
                    }
                    
                    if let definedError = error as? QueueAPIError.MyQueueState {
                        print("🧸 QueueAPIError.MyQueueState: \(definedError)")
                        print("🐚 MyQueueState 201")
                        self?.alert(title: String.Chats.defaultState, message: String.Chats.matchingNeeded)
                    }
            }
        }
    }
    
    private func fetchChats(from lastChatDate: String) {
        ChatAPIManager.fetchChat(from: matchedUid, lastChatDate: "2022-01-01T00:00:00.000Z") { [weak self] result in
            switch result {
                case .success(let payload):
//                    self?.refreshIDToken()
                    print(payload.payload)
                    
                    // 여기서 realm에 add 후 realm fetch 후 테이블뷰 리로드
                    // 그리고 테이블뷰 제일 밑으로 내린 후 소켓 연결!!
                    
//                    self?.repository.add(payload.payload) {
//                        // realm fetch 후 테이블뷰 리로드 후 스크롤 후 소켓 연결
//                        self?.fetchChatsFromDB(isAfterFetchingFromServer: true) {
//                            self?.chatsView.tableView.reloadData()
//
//                            // 스크롤 후 소켓 연결
//                            self?.scrollToBottom()
//
//                        }
//                    } errorHandler: {
//                        self?.alert(title: String.Alert.errorAlert, message: String.Alert.chatSaveError)
//                    }
                case .failure(let error):
                    print("🐰 ChatsVC \(error)")
                    if let definedError = error as? QueueAPIError {
                        print("🧸 QueueAPIError: \(definedError)")
                        if definedError == .firebaseTokenError {
                            self?.refreshIDToken {
                                guard let areChatsEmpty = self?.chats.isEmpty else {
                                    print("areChatsEmpty 옵셔널 체이닝 실패")
                                    return
                                }
                                
                                if areChatsEmpty {
                                    self?.fetchChats(from: String.Chats.lastChatDateIfChatsEmpty)
                                } else {
                                    guard let newestChatDateInDB = self?.repository.newestChatDateInDB() else {
                                        print("최신 채팅 찾기 실패!!")
                                        return
                                    }
                                    self?.fetchChats(from: newestChatDateInDB)
                                }
//                                self?.fetchChats()
                            }
                        } else {
                            print("🐰 ChatsVC \(definedError)")
                        }
                        return
                    }
            }
        }
    }
    
    private func fetchChatsAF(from lastChatDate: String) {
        print(#function)
        let headers: HTTPHeaders = [
            "idtoken": UserDefaults.idToken,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let url = "http://api.sesac.co.kr:1210/v1/chat/eT7g1xuSfDPfGl83Id23NkvgJvx1?lastchatDate=\(lastChatDate)"
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Payload.self) { [weak self] response in
            switch response.result {
            case .success(let payload):
                    print("😭 \(payload)")

                    // 여기서 realm에 add 후 realm fetch 후 테이블뷰 리로드
                    // 그리고 테이블뷰 제일 밑으로 내린 후 소켓 연결!!
                    
                    self?.repository.add(payload.payload) {
                        // realm fetch 후 테이블뷰 리로드 후 스크롤 후 소켓 연결
                        self?.fetchChatsFromDB(isAfterFetchingFromServer: true) {
                            self?.chatsView.tableView.reloadData()

                            // 스크롤 후 소켓 연결
                            self?.scrollToBottom()

                        }
                    } errorHandler: {
                        self?.alert(title: String.Alert.errorAlert, message: String.Alert.chatSaveError)
                    }
                    
//                    self?.chat = value
//                    self?.tableView.reloadData()
//                    self?.tableView.scrollToRow(at: IndexPath(row: self!.chat.count - 1, section: 0),
//                                               at: .bottom,
//                                               animated: false)
//                    SocketIOManager.shared.establishConnection()  // 과거의 채팅을 먼저 처리하기 위해 여기에서 구현
            case .failure(let error):
                    print("FAIL", error)
                    
                    guard let statusCode = response.response?.statusCode else {
                        print("fetchChatsAF statusCode 옵셔널 체이닝 실패")
                        return
                    }
                    
                    guard let definedError = QueueAPIError(rawValue: statusCode) else {
                        print("fetchChatsAF error QueueAPIError 변경 실패")
                        return
                    }
                    
                    if definedError == .firebaseTokenError {
                        self?.refreshIDToken {
                            guard let areChatsEmpty = self?.chats.isEmpty else {
                                print("areChatsEmpty 옵셔널 체이닝 실패")
                                return
                            }
                            
                            if areChatsEmpty {
                                self?.fetchChatsAF(from: String.Chats.lastChatDateIfChatsEmpty)
                            } else {
                                guard let newestChatDateInDB = self?.repository.newestChatDateInDB() else {
                                    print("최신 채팅 찾기 실패!!")
                                    return
                                }
                                self?.fetchChatsAF(from: newestChatDateInDB)
                            }
                        }
                    } else {
                        print("🐰 firebaseTokenError 이외 다른 오류: \(definedError)")
                    }
            }
        }
    }
    
    private func sendChat() {
        ChatAPIManager.sendChat(to: matchedUid, chat: chatsView.chatTextView.text) { [weak self] result in
            switch result {
                case .success(let chat):
//                    print(chat)
                    self?.chatsView.chatTextView.text.removeAll()
                case .failure(let error):
                    print("🐰 sendChat \(error)")
                    if let definedError = error as? QueueAPIError {
                        print("🧸 QueueAPIError: \(definedError)")
                        if definedError == .firebaseTokenError {
                            self?.refreshIDToken {
                                self?.sendChat()
                            }
                        } else {
                            print("🐰 ChatsVC \(definedError)")
                        }
                        return
                    }
                    
                    if let definedError = error as? QueueAPIError.SendChat {
                        print("🧸 QueueAPIError.SendChat: \(definedError)")
                        print("🐚 SendChat 201")
                        self?.alert(title: String.Chats.defaultState, message: String.Chats.matchingNeeded)
                    }
            }
        }
    }
}
