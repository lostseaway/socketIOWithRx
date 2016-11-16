//
//  Networking.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/14/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//
import SocketIO
import RxSwift

struct Client {
    static let socketBase = "http://localhost:3000"
    let socket:Socket
    var userName: String
    
    init() {
        userName = ""
        socket = Socket(baseURL: Client.socketBase)
        socket.connect()
    }
}

protocol BaseSocket {
    func listenTo(event: String) -> Observable<NSDictionary>
    func emit(event: String, data: [Any])
    func connect()
    func disconnect()

    init(baseURL: String)
}

struct Socket: BaseSocket {
    let socket:SocketIOClient
    
    init(baseURL: String) {
        let url = URL(string: baseURL)!
        self.socket = SocketIOClient(socketURL: url , config: [.forcePolling(true)])
    }
    
    func listenTo(event: String) -> Observable<NSDictionary> {
        return Observable.create { observer in
            self.socket.on(event, callback: { data , ack in
                if let reponse = (data[0] as? NSDictionary) {
                    observer.on(.next(reponse))
                } else {
                    let error = NSError(domain: "Response isn't a dict.", code: 999, userInfo: nil)
                    observer.onError(error)
                }
                
            })
            return Disposables.create()
        }
    }
    
    func emit(event: String, data: [Any]) {
        socket.emit(event, with: data)
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
}

protocol SocketEvent {
    func listen() -> Observable<T>
    
    var eventName: String { get set }
    var socket: BaseSocket { get set }
}

extension SocketEvent {
    typealias T = NSDictionary
    
    func listen() -> Observable<NSDictionary> {
        return socket.listenTo(event: eventName)
    }
}
