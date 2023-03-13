//
//  BaseView.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit

class BaseView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        bindConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setup() {}
    
    func bindConstraints() {}
}
