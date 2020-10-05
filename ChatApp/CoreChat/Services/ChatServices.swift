//
//  ChatServices.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import Foundation
import Firebase
import FirebaseDatabase
import ObjectMapper
import FirebaseStorage

typealias completion = (Bool) -> Void

class ChatService {
    var sender: ChatUser
    var receiver: ChatUser
    var delegate:ChatServiceDelegate?
    
    required init(sender:ChatUser, receiver:ChatUser) {
        self.sender = sender
        self.receiver = receiver
    }
}


//Mark:Actions
extension ChatService {
    
    func sendMessage(_ message: MessageModel) {
        var flag = 0
        var msg = message
        var msgJson = Mapper().toJSON(message)
        msgJson.updateValue(ServerValue.timestamp(), forKey: MKey.timestamp)
        print(msgJson)
        //Save in sender node
        self.senderMessagesNode.childByAutoId().setValue(msgJson) { (err, ref) in
            msg.uniqueId = ref.key
            flag += 1
            if err == nil {
                self.saveSenderMeta(msg)
            }
            flag = self.checkFlag(val: flag, message: msg)
        }
        
        //Save in receiver node
        self.receiverMessagesNode.childByAutoId().setValue(msgJson, withCompletionBlock: {
            (error, ref) in
            flag = flag + 1
            msg.uniqueId = ref.key
            if error == nil {
                self.saveReceiverMeta(msg)
            }
            flag = self.checkFlag(val: flag, message:msg)
        })
    }
    
    func checkFlag(val:Int, message:MessageModel) -> Int{
        if val == 2 {
            self.delegate?.messageAdded(message)
            return 0
        } else {
            self.delegate?.messageFailedToDeliver()
            return val
        }
    }
    
    fileprivate func saveSenderMeta(_ message:MessageModel) {
        let meta = LastMessageModel(withMessage: message)
        let metaJson = Mapper().toJSON(meta)
        self.senderMetaMessagesNode.setValue(metaJson)
    }
    
    fileprivate func saveReceiverMeta(_ message:MessageModel) {
        var meta = LastMessageModel(withMessage: message)

        self.receiverMetaMessagesNode.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            //If user had set the message meta before get the unseeCount
            if let messageMeta = snapshot.value as? [String : AnyObject] {
                let unseenValue = messageMeta[LMKey.unseenCount] as! Int
                meta.unSeenCount = unseenValue + 1
            } else {
                meta.unSeenCount = 1
            }
            
            let metaJson = Mapper().toJSON(meta)
            self.receiverMetaMessagesNode.setValue(metaJson)
        })
    }
    
    func deleteMessage(_ responseHandler: completion) {
        
    }
    
    func updateLastMessageCount() {
        
    }
    
    func blockUserUpdate() {
        
    }
    
    func unBlockUserUpdate() {
        
    }
}


//MARK: Nodes
extension ChatService {
    
    var senderMessagesNode:DatabaseReference {
        get {
            return FNode.messagesNode.child("\(sender.userId!)/\(receiver.userId!)")//"
        }
    }
    
    var receiverMessagesNode:DatabaseReference {
        get {
            return FNode.messagesNode.child("\(receiver.userId!)/\(sender.userId!)")
            
        }
    }
    
    var senderMetaMessagesNode:DatabaseReference {
        get {
           return FNode.messagesMetaNode.child("\(sender.userId!)/\(receiver.userId!)")
        }
    }
    
    var receiverMetaMessagesNode:DatabaseReference {
        get {
        return FNode.messagesMetaNode.child("\(receiver.userId!)/\(sender.userId!)")
        }
    }
    
}
