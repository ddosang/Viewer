//
//  MessageModel+CoreDataProperties.swift
//  Viewer
//
//  Created by 임은지 on 2023/04/03.
//
//

import Foundation
import CoreData


extension MessageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageModel> {
        return NSFetchRequest<MessageModel>(entityName: "MessageModel")
    }

    @NSManaged public var nickname: String
    @NSManaged public var type: String
    @NSManaged public var message: String
    @NSManaged public var date: Date

    var msg: Message {
        get {
            return Message(nickname: self.nickname,
                           type: MessageType(rawValue: self.type) ?? .text,
                           message: self.message,
                           date: self.date)
        }
        set {
            self.nickname = newValue.nickname
            self.type = newValue.type.rawValue
            self.message = newValue.message
            self.date = newValue.date
        }
    }
}

extension MessageModel : Identifiable {

}
