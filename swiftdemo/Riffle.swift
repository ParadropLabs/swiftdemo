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
    
    func handle(args: AnyObject...) {
        
    }
    
    //MARK: Delegates
    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!) {
        print("Session Established!")
        onJoin()
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!) {
        print("Session Closed!")
        onLeave()
    }
    
    func onJoin() {
        // Called when a session closes. Setup here.
    }
    
    func onLeave() {
        // called when a session closes. Do any cleanup here
    }
    
    
    //MARK: Messaging Patterns
    func registerZ(pdid: String, callback: (AnyObject... ) -> ()) {
        
    }

    func testsubscribe(endpoint: String, handler: () -> ()) {
        session.subscribe(endpoint, onEvent: { (event: MDWampEvent!) -> Void in
            print("Sub came in: ", event)
            handler()
            
            }) { (err: NSError!) -> Void in
                if let e = err {
                    print("An error occured: ", e)
                }
                else {
                    print("Sub completed")
                }
        }
    }
    
    func subscribe(endpoint: String, handler: () -> ()) {
        session.subscribe(endpoint, onEvent: { (event: MDWampEvent!) -> Void in
            print("Sub came in: ", event)
            handler()
            
        }) { (err: NSError!) -> Void in
            if let e = err {
                print("An error occured: ", e)
            }
            else {
                print("Sub completed")
            }
        }
    }
    
    func call(endpoint: String, args: AnyObject...) {
        session.call(endpoint, payload: args) { (result: MDWampResult!, err: NSError!) -> Void in
            if err != nil {
                print("ERR: ", err)
            }
            else {
                print("Call completed")
            }
        }
    }
}

