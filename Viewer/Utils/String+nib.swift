//
//  String+nib.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import Foundation
import UIKit

extension String {
    var nib: UINib {
        return UINib(nibName: self, bundle: nil)
    }
}
