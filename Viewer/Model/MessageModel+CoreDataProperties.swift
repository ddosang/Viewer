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

    @NSManaged public var nickname: String?
    @NSManaged public var type: String?
    @NSManaged public var message: String?
    @NSManaged public var date: Date?

}

extension MessageModel : Identifiable {

}
