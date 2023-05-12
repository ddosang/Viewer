//
//  DailyMessageModel+CoreDataProperties.swift
//  Viewer
//
//  Created by 임은지 on 2023/05/12.
//

import Foundation
import CoreData

extension DailyMessageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyMessageModel> {
        return NSFetchRequest<DailyMessageModel>(entityName: "DailyMessageModel")
    }

    @NSManaged public var idol: IdolModel
    @NSManaged public var day: Date
    @NSManaged public var index: Int
    @NSManaged public var messages: Set<MessageModel>

    var dailyMsg: DailyMessage {
        get {
            return DailyMessage(day: self.day, index: self.index)
        }
        set {
            self.day = newValue.day
            self.index = newValue.index
        }
    }
}

extension DailyMessageModel : Identifiable {

}
