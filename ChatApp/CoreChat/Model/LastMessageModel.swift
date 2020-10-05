//
//  LastMessageModel.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import Foundation
import ObjectMapper

struct LastMessageModel : Mappable {
    var senderId:String?
    var receiverId:String?
    var message:String?
    var timestamp:Double?
    var uniqueId:String?
    var mediaImageUrl:String?
    var isMedia: Bool?
    var isSeen:Bool?
    var unSeenCount:Int?
    
    init(senderId:String, receiverId:String, message:String, uniqueId: String,mediaImageUrl: String, isMedia:Bool, isSeen:Bool, unSeenCount : Int) {
        self.senderId    = senderId
        self.receiverId  = receiverId
        self.message   = message
        self.uniqueId  = uniqueId
        self.mediaImageUrl  = mediaImageUrl
        self.isMedia       = isMedia
        self.isSeen = isSeen
        self.unSeenCount = unSeenCount
    }
    
    init(withMessage message:MessageModel) {
        self.senderId = message.senderId
        self.receiverId = message.receiverId
        self.message = message.message
        self.timestamp = message.timestamp
        self.uniqueId = message.uniqueId
        self.mediaImageUrl = message.mediaImageUrl
        self.isMedia = message.isMedia
        self.isSeen = message.isSeen
        self.unSeenCount = 1
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        senderId <- map["senderId"]
        receiverId <- map["receiverId"]
        message <- map["message"]
        timestamp <- map["timestamp"]
        uniqueId <- map["uniqueId"]
        mediaImageUrl <- map["mediaImageUrl"]
        isMedia <- map["isMedia"]
        isSeen  <- map["isSeen"]
        unSeenCount <- map["unSeenCount"]
    }
}
