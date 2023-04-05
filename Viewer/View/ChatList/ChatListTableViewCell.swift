//
//  ChatListTableViewCell.swift
//  Viewer
//
//  Created by 임은지 on 2023/04/05.
//

import UIKit

class ChatListTableViewCell: BaseTableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setup() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 20
        messageLabel.lineBreakMode = .byWordWrapping
    }
}
