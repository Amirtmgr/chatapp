//
//  ChatUser.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import Foundation
import ObjectMapper

class ChatUser:Mappable {
    var name:String?
    var userId:String?
    var profileImageUrl:String?
    
    init(name:String,userId:String, profileImageUrl:String?) {
        self.name = name
        self.userId = userId
        self.profileImageUrl = profileImageUrl
    }
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        userId <- map["userId"]
        profileImageUrl <- map["profileImageUrl"]
    }
}
