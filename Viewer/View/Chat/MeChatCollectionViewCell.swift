//
//  MeChatCollectionViewCell.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit

class MeChatCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setup() {
        messageView.backgroundColor = .systemBlue
        messageView.layer.cornerRadius = 15
        messageLabel.textColor = .white
        messageLabel.lineBreakMode = .byCharWrapping
    }
}
