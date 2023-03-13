//
//  Date+toString.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import Foundation

extension String {
    func toDate() -> Date {
        // utcString -> utc
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        utcDateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return utcDateFormatter.date(from: self)!
    }
}
