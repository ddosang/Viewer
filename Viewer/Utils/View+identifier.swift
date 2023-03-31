//
//  NSObject+identifier.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/31.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
