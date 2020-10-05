//
//  FirebaseConstants.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import FirebaseDatabase
import Firebase

struct MKey {
    static let senderId   = "senderId"
    static let receiverId = "receiverId"
    static let message    = "message"
    static let timestamp  = "timestamp"
    static let uniqueId   = "uniqueId"
    static let mediaImageUrl  = "mediaImageUrl"
    static let mediaVideoUrl  = "mediaVideoUrl"
    static let isMedia    = "media"
    static let isVideo    = "video"
}

struct LMKey {
    static let message         = "message"
    static let timestamp       = "timestamp"
    static let messageID       = "messageID"
    static let unseenCount     = "unSeenCount"
    static let userDisplayName = "userDisplayName"
    static let userProfileURL  = "userProfileURL"
    static let userFBID        = "userFBID"
}

struct GroupChatKey {
    static let senderId   = "userid"
    static let message    = "message"
    static let timestamp  = "timestamp"
    static let uniqueId   = "uniqueId"
}

struct NotificationKey {
    static let uid            = "uid"
    static let type           = "type"
    static let seenStatus     = "seenStatus"
    static let timestamp      = "timestamp"
    
    static let senderUid      = "senderUid"
    static let senderFullName = "senderFullName"
    static let senderImageUrl = "senderImageUrl"
    
    static let eventUid       = "eventUid"
    static let eventName      = "eventName"
    static let eventImageUrl  = "eventImageUrl"
}

struct NotificationMetaKey {
    static let viteCount    = "viteCount"
    static let messageCount = "messageCount"
    static let eventCount   = "eventCount"
}

struct FNode {
    static var rootRef:DatabaseReference{
        if Config.isLive {
            return Database.database().reference().child("live")
        } else {
            return Database.database().reference().child("test")
        }
    }
  
    static var messagesNode:DatabaseReference {
        return self.rootRef.child("messages")
    }
    
    static var messagesMetaNode:DatabaseReference
    {
        return self.rootRef.child("messagesMeta")
    }
}
