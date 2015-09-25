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
    func register(endpoint: String, callback: (AnyObject... ) -> ()) {
        session.registerRPC(endpoint, procedure: { (wamp: MDWamp!, invocation: MDWampInvocation!) -> Void in
            print("Someone called hello: ", invocation)
            
            //print("", invocation.request)
            //print("", invocation.registration)
            //print("", invocation.options)
            //print("", invocation.arguments)
            //print("", invocation.argumentsKw)
            
            callback(invocation.arguments)
            
            }, cancelHandler: { () -> Void in
                print("Register Cancelled!")
            }) { (err: NSError!) -> Void in
                print("Registration completed.")
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
    
    func publish(endpoint: String, args: AnyObject...) {
        session.publishTo(endpoint, payload: args, result: { (err: NSError!) -> Void in
            if let e = err {
                print("Error: ", e)
            }
        })
    }
    
    func subscribe(endpoint: String, callback: (AnyObject...) -> ()) {
        session.subscribe(endpoint, onEvent: { (event: MDWampEvent!) -> Void in
            print("Sub came in: ", event)
            
            //print("", event.subscription)
            //print("", event.publication)
            //print("", event.topic)
            print("", event.details)
            print("", event.arguments)
            //print("", event.argumentsKw)
            //print("", event.event)
            
            callback(event.arguments)
            
            }) { (err: NSError!) -> Void in
                if let e = err {
                    print("An error occured: ", e)
                }
                else {
                    print("Sub completed")
                }
        }
    }
}

/*
Getting the signature from provided handler:

func f(a: Int, b: Int) {
}

let y = Mirror(reflecting: f)

let types = y.subjectType
print(types)


*/

