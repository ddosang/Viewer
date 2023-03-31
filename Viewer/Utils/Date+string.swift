//
//  Date+string.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/31.
//

import Foundation

extension Date {
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
