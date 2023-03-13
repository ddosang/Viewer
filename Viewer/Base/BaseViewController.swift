//
//  BaseViewController.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNaviation()
        setup()
        bindConstraints()
    }
    
    func setUpNaviation() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setup() {
        view.backgroundColor = .white
    }
    
    func bindConstraints() {}

}
