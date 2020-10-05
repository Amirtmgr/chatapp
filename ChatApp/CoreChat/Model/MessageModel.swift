//
//  MessageModel.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import Foundation
import ObjectMapper

struct MessageModel:Mappable {
    var senderId:String?
    var receiverId:String?
    var message:String?
    var timestamp:Double?
    var uniqueId:String?
    var mediaImageUrl:String?
    var isMedia: Bool?
    var isSeen:Bool?
    
    init(senderId:String?, receiverId:String?, message:String?, uniqueId: String? = nil, mediaImageUrl: String? = nil, isMedia:Bool?, isSeen:Bool?) {
        self.senderId    = senderId
        self.receiverId  = receiverId
        self.message   = message
        self.uniqueId  = uniqueId
        self.mediaImageUrl  = mediaImageUrl
        self.isMedia       = isMedia
        self.isSeen        = isSeen
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
    }
 
    func getDate()->String? {
        if let val = self.timestamp {
            return convertToDateFromTimestamp(timestamp: val)
        }
        return nil
    }
}
