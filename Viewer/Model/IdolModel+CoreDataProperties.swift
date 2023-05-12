//
//  IdolModel+CoreDataProperties.swift
//  Viewer
//
//  Created by 임은지 on 2023/05/12.
//

import Foundation
import CoreData

extension IdolModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<IdolModel> {
        return NSFetchRequest<IdolModel>(entityName: "IdolModel")
    }
    
    @NSManaged public var nickname: String
    @NSManaged public var profileImageName: String
    @NSManaged public var lastDate: Date
    @NSManaged public var lastMessage: String
    @NSManaged public var message: Set<DailyMessageModel>
    
    
    var idol: Idol {
        get {
            return Idol(nickname: nickname, profileImageName: profileImageName, lastDate: lastDate, lastMessage: lastMessage)
        }
        set {
            self.nickname = newValue.nickname
            self.profileImageName = newValue.profileImageName
            self.lastDate = newValue.lastDate
            self.lastMessage = newValue.lastMessage
        }
    }
}

extension IdolModel : Identifiable {
    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: DailyMessageModel)
    
    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: DailyMessageModel)
    
    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: Set<DailyMessageModel>)
    
    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: Set<DailyMessageModel>)
}
