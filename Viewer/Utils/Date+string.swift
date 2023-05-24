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
    
    var dayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: self)
    }
    
    var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        return Int("\(components.year)\(components.month)\(components.day)")!
    }
}
