//
//  BaseView.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit

class BaseView: UIView {
    
    // xib 로 만들어서 불러올 때
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        bindConstraints()
    }
    
    // 코드로 만들어서 불러올 때
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
