//
//  MeChatCollectionViewCell.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit

class MeChatCollectionViewCell: BaseCollectionViewCell {

    static let identifier = "MeChatCollectionViewCell"
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    override func setup() {
        messageView.backgroundColor = .systemBlue
        messageView.layer.cornerRadius = 10
        messageLabel.textColor = .white
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.lineBreakStrategy = .hangulWordPriority
    }

    func cellHeight() -> CGFloat {
        messageLabel.sizeToFit()
        
        return messageLabel.frame.height + 20
    }
}
