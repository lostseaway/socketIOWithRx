//
//  Message.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/16/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//
enum MessageType {
    case user
    case system
}

protocol Message {
    var type: MessageType { get set }
    var message: String { get set }
}

struct UserMessage: Message {
    var type: MessageType = .user
    var message: String
    var user: String
    
    init(message: String, user: String) {
        self.message = message
        self.user = user
    }
}
