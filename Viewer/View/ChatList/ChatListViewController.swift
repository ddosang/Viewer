//
//  ChatListViewController.swift
//  Viewer
//
//  Created by 임은지 on 2023/04/05.
//

import UIKit

class ChatListViewController: BaseViewController {

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
    }

    override func setup() {
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatListTableViewCell.identifier.nib, forCellReuseIdentifier: ChatListTableViewCell.identifier)
    }

}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTableViewCell.identifier, for: indexPath) as? ChatListTableViewCell {
            cell.profileImageView.image = UIImage(named: "test")
            cell.nameLabel.text = "루디"
            cell.messageLabel.text = "Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum."
            cell.dateLabel.text = "2023-04-05"
            
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
