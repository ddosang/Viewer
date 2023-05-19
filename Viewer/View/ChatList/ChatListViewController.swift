//
//  ChatListViewController.swift
//  Viewer
//
//  Created by 임은지 on 2023/04/05.
//

import UIKit
import UniformTypeIdentifiers

class ChatListViewController: BaseViewController {
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: MessageViewModel
    
    
    init(viewModel: MessageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ChatListViewController.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.idolList = MessageViewModel.fetchIdol()
    }

    override func setUpNaviation() {
        title = "채팅"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(uploadFile))
    }
    
    override func setup() {
        indicator.hidesWhenStopped = true
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatListTableViewCell.identifier.nib, forCellReuseIdentifier: ChatListTableViewCell.identifier)
//        tableView.register(ChastListTableViewCell.self, forCellReuseIdentifier: ChatListTableViewCell.identifier) // TODO: 이건 왜 안 되는지 원인을 알아내기!!
    }

    @objc func uploadFile() {
        let supportedTypes: [UTType] = [UTType.data]
        let documentPickerVC = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        documentPickerVC.delegate = self
        documentPickerVC.allowsMultipleSelection = false
        documentPickerVC.modalPresentationStyle = .formSheet
        indicator.startAnimating()
        self.present(documentPickerVC, animated: true)
    }
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.idolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as? ChatListTableViewCell {
            let idol = viewModel.idolList[indexPath.row]
            cell.profileImageView.image = UIImage(named: "test")
            cell.nameLabel.text = idol.nickname
            cell.messageLabel.text = idol.lastMessage
            cell.dateLabel.text = idol.lastDate.timeString
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
}

extension ChatListViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        parseCSV(with: urls.first!)
        indicator.stopAnimating()
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        indicator.stopAnimating()
        controller.dismiss(animated: true)
    }
    
    func parseCSV(with url: URL) {
        do {
            let data = try Data(contentsOf: url)
            guard let dataEncoded = String(data: data, encoding: .utf8) else { return }
            
            var arr = dataEncoded.components(separatedBy: "\r\n")
            
            // 맨 첫번째 줄 삭제, 맨 마지막 비어있는 한 줄 삭제.
            arr.removeFirst()
            if let last = arr.last,
               last == "" {
                arr.removeLast()
            }
            
            // 구분자 | 로 분리.
            let separated = arr.map ({ $0.components(separatedBy: ",") })
            
            // Message 객체로 만들기
            self.viewModel.messageList = separated.compactMap { Message(data: $0) }
            
            let idol = makeIdol(messages: self.viewModel.messageList)
            
        } catch {
            print("Error reading CSV file")
        }
    }
    
    func makeIdol(messages: [Message]) -> Idol? {
        // TODO: 이미 있는 아이돌이면 저장 못하게 막을 것.
        guard let firstMessage = messages.first,
              let lastMessage = messages.last else { return nil }
        
        var index = 0
        var previousDate = firstMessage.date // 이거 일까지만으로 처리해야됨.
        var arr = [Message]()
        var dailyArr = [DailyMessage]()
        
        for message in messages {
            if previousDate == message.date {
                arr.append(message)
            } else {
                dailyArr.append(DailyMessage(day: previousDate, index: index, messages: arr))
                
                index += 1
                // 날짜가 달라지면 지금까지 arr 저장하고 다음 arr 에 저장.
                previousDate = message.date
                arr = [message]
            }
        }
        
        return Idol(nickname: firstMessage.nickname, profileImageName: "", lastDate: lastMessage.date, lastMessage: lastMessage.message, dailyMessages: dailyArr)
    }
}
