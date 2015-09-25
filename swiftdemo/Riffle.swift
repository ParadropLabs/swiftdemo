//
//  Riffle.swift
//
//  Created by Mickey Barboi on 9/25/15.
//  Copyright © 2015 paradrop. All rights reserved.
//


import Foundation

//let NODE = "ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"
let NODE = "ws://localhost:8000/ws"


class RiffleSession: NSObject, MDWampClientDelegate {
    var socket: MDWampTransportWebSocket
    var session: MDWamp
    
    init(pdid: String) {
        socket = MDWampTransportWebSocket(server:NSURL(string: NODE), protocolVersions:[kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json])
        
        // Oh, the hacks you'll see
        session = MDWamp()
        super.init()
        
        session = MDWamp(transport: socket, realm: pdid, delegate: self)
    }
    
    func connect() {
        session.connect()
    }
    
    //MARK: Delegates
    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!) {
        print("Session Established!")
        
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!) {
        print("Session Closed!")
    }
    
    //MARK: Messaging Patterns
    func register(pdid: String, callback: (AnyObject... ) -> ()) {
        
    }
    
    func call() {
        
    }
}

