//
//  ChatProtocol.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import Foundation

protocol ChatServiceDelegate {
    func messageAdded(_ message:MessageModel)
    func messageDeleted(_ message:MessageModel)
    func messageIsDelivered(_ message:MessageModel)
    func messageFailedToDeliver()
}
