//
//  MessageViewModel.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/31.
//

import Foundation
import UIKit
import CoreData

class MessageViewModel {
    var idolList: [Idol] = []
    var messageList: [Message] = []
    
    static func storeMsg() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "MessageModel", in: context)
        
        
        let msg = Message(nickname: "또상", type: .text, message: "하이하이~~", date: Date())
        if let entity = entity {
            let msgModel = NSManagedObject(entity: entity, insertInto: context)
            msgModel.setValue(msg.nickname, forKey: "nickname")
            msgModel.setValue(msg.type.rawValue, forKey: "type")
            msgModel.setValue(msg.message, forKey: "message")
            msgModel.setValue(msg.date, forKey: "date")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static func fetchMsg() -> [Message] {
        var messages = [Message]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return messages }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let messageModel = try context.fetch(MessageModel.fetchRequest())
            messageModel.forEach {
                messages.append(Message(messageModel: $0))
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return messages
    }
    
    
    static func storeIdol() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "IdolModel", in: context)
        
        
        let idol = Idol(nickname: "또상", profileImageName: "", lastDate: Date(), lastMessage: "하이하이~~~~~")
        if let entity = entity {
            let idolModel = NSManagedObject(entity: entity, insertInto: context)
            idolModel.setValue(idol.nickname, forKey: "nickname")
            idolModel.setValue(idol.profileImageName, forKey: "profileImageName")
            idolModel.setValue(idol.lastDate, forKey: "lastDate")
            idolModel.setValue(idol.lastMessage, forKey: "lastMessage")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static func fetchIdol() -> [Idol] {
        var idols = [Idol]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return idols }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let idolModel = try context.fetch(IdolModel.fetchRequest())
            idolModel.forEach {
                idols.append(Idol(idolModel: $0))
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return idols
    }
}
