//
//  ChatsViewController.swift
//  SeSACStudy
//
//  Created by SC on 2022/11/27.
//

import UIKit

final class ChatsViewController: BaseViewController {
    // MARK: - Properties
    let chatsView = ChatsView()
    var dummy: [String] = []
    
    // MARK: - Life Cycle
    override func loadView() {
        view = chatsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        configureDummyChat()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showToast(message: "Chats")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = chatsView.tableView.tableHeaderView else {
          return
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
           headerView.frame.size.height = size.height
            chatsView.tableView.tableHeaderView = headerView
            chatsView.tableView.layoutIfNeeded()
        }
    }

    
    // MARK: - Setting Methods
    private func setNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = AppAppearance.navigationBarAppearance
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
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("🦉")
        let chat = dummy[indexPath.row]
        
        if indexPath.row.isMultiple(of: 2) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? ReceivedTableViewCell else {
                return UITableViewCell()
            }
            cell.chatLabel.text = chat
            cell.timeLabel.text = "몇 시"
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SentTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? SentTableViewCell else {
                return UITableViewCell()
            }
            
            cell.chatLabel.text = chat
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
        return MatchedHeaderView()
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatsViewController {
    private func configureDummyChat() {
        dummy = ["안녕하세요", "반갑습니다", "별명이 왜 모찌인가요?", "세상에서\n모찌가 젤\n맛있더라구요", "아...", "안녕하세요 알고리즘 스터디는 언제 하실 생각이세요?", "안녕하세요! 저 평일은 저녁 8시에 꾸준히 하는데 7시부터 해도 괜찮아요", "안녕하세요! 저 평일은 저녁 8시에 꾸준히 하는데 7시부터 해도 괜찮아요 안녕하세요! 저 평일은 저녁 8시에 꾸준히 하는데 7시부터 해도 괜찮아요"]
    }
}
