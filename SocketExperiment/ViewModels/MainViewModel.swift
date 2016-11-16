//
//  MainViewModel.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/16/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//
import RxSwift

class MainViewModel {
    var client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func login(name:String?) -> Observable<NSDictionary> {
        guard let sname = name else {
            return Observable.create { observable in
                observable.onError(NSError(domain: "nil textfield", code: 999, userInfo: nil))
                observable.onCompleted()
                return Disposables.create()
            }
            
        }
        client.socket.emit(event: "add user", data: [sname])
        return LoginSocketEvent(socket: client.socket).listen()
    }
    
}

struct LoginSocketEvent: SocketEvent {
    var eventName: String = "login"
    var socket: BaseSocket
    
    init(socket: BaseSocket) {
        self.socket = socket
    }
}
