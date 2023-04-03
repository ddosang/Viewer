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
    
    static func fetchMsg() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
                
            do {
               let message = try context.fetch(MessageModel.fetchRequest())
               message.forEach {
                  print($0.message)
              }
            } catch {
               print(error.localizedDescription)
            }
    }
}
