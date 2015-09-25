//
//  ViewController.swift
//  swiftdemo
//
//  Created by Mickey Barboi on 9/24/15.
//  Copyright (c) 2015 paradrop. All rights reserved.
//

import UIKit

//let URL = "ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"
let URL = "ws://localhost:8000/ws"


class ViewController: UIViewController, MDWampClientDelegate {
    var socket: MDWampTransportWebSocket?
    var session: MDWamp?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Attempting to connect...")
        
        socket = MDWampTransportWebSocket(server:NSURL(string: URL), protocolVersions:[kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json])
        session = MDWamp(transport: socket, realm: "pd.damouse", delegate: self)
        session?.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!) {
        print("Session Established!")
        
        session?.call("pd.damouse.quick/hello", payload: "Hello!", complete: { (resutl:MDWampResult!, err:NSError!) -> Void in
            print("Request completed!")
        })
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!) {
        print("Session Closed!")
    }

}

