//
//  String+getEstimatedFrame.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/27.
//  참고 : https://ios-development.tistory.com/747

import Foundation
import UIKit

extension String {
    func estimatedFrame(with fontSize: CGFloat) -> CGRect {
        let size = CGSize(width: UIScreen.main.bounds.width * 0.66, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
    }
}
