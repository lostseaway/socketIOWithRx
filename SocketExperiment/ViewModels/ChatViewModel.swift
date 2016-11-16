//
//  ChatViewModel.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/16/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import RxSwift

class ChatViewModel {
    var messages = [Message]()
    
    lazy var messagesVariable: Variable<[Message]> = {
        return Variable(self.messages)
    }()
    
    var client: Client
    let disposeBag = DisposeBag()
    
    init(client: Client) {
        self.client = client
        bindSignal()
    }
    
    func bindSignal() {
        NewMessageSocketEvent(socket: client.socket).listen().map{ response -> UserMessage in
            guard let msg = (response["message"] as? String), let user = (response["username"] as? String) else {
                return UserMessage(message: "", user: "")
            }
            return UserMessage(message: msg, user: user)
        }.subscribe(onNext:{ message in
            if message.user != "" {
                self.messages.append(message)
                self.messagesVariable.value = self.messages
            }
        }).addDisposableTo(disposeBag)
    }
    
    func sendMessage(msg: String) {
        if msg != "" {
            client.socket.emit(event: "new message", data: [msg])
            messages.append(UserMessage(message: msg, user: client.userName))
            self.messagesVariable.value = self.messages
        }
    }
}

struct NewMessageSocketEvent: SocketEvent {
    var eventName: String = "new message"
    var socket: BaseSocket
    
    init(socket: BaseSocket) {
        self.socket = socket
    }
    
}
