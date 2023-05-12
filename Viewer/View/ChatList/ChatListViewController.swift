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
        
        let vc = ChatViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
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
            
            // 맨 마지막 한 줄이 비어있다면 삭제.
            if let last = arr.last,
               last == "" {
                arr.removeLast()
            }
            
            // 구분자 | 로 분리.
            let separated = arr.map ({ $0.components(separatedBy: "|") })
            
            // Message 객체로 만들기
            self.viewModel.messageList = separated.compactMap { Message(data: $0) }
        } catch {
            print("Error reading CSV file")
        }
    }
}
