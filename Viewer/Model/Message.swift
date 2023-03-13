//
//  Message.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import Foundation

struct Message: Codable {
    let nickname: String // 루디
    let type: MessageType // TEXT
    let message: String // 처음이라 조금 어렵넹ㅎㅎㅎ
    let date: Date // 2021-2-1 8:14 AM
    
    init(nickname: String, type: MessageType, message: String, date: Date) {
        self.nickname = nickname
        self.type = type
        self.message = message
        self.date = date
    }
    
    init(nickname: String, type: MessageType, message: String, dateStr: String) {
        self.init(nickname: nickname, type: type, message: message, date: dateStr.toDate())
    }
    
    init(data: [String]) {
        self.init(nickname: data[0],
                  type: MessageType(rawValue: data[1])!,
                  message: data[2],
                  dateStr: data.last!)
    }
    
    
}

enum MessageType: String, Codable {
    case text = "TEXT"
    case image = "IMAGE"
    case voice = "VOICE"
    case video = "VOD"
}
