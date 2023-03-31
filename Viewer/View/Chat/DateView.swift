//
//  DateView.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/31.
//

import UIKit

class DateView: UICollectionReusableView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        backgroundView.backgroundColor = .systemGray2
        backgroundView.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        dateLabel.textColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }
}
