//
//  IdolChatCollectionViewCell.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/31.
//

import UIKit

class IdolChatCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var messageViewTopConstraint: NSLayoutConstraint!
    
    var isProfileShowing: Bool = false {
        didSet {
            nameLabel.isHidden = !isProfileShowing
            profileImageView.isHidden = !isProfileShowing
            messageViewTopConstraint.constant = isProfileShowing ? 25 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setup() {
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 17.5
        profileImageView.image = UIImage(named: "test")!
        
        messageView.backgroundColor = .systemGray4
        messageView.layer.cornerRadius = 15
        messageLabel.textColor = .black
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.lineBreakStrategy = .hangulWordPriority
    }
    
    override func prepareForReuse() {
        isProfileShowing = false
        messageLabel.text = nil
        super.prepareForReuse()
    }
}
