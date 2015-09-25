//
//  ViewController.swift
//  swiftdemo
//
//  Created by Mickey Barboi on 9/24/15.
//  Copyright (c) 2015 paradrop. All rights reserved.
//

import UIKit

let URL = "ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"
//ws://localhost:8080/ws

class ViewController: UIViewController, MDWampClientDelegate {
    var socket: MDWampTransportWebSocket?
    var session: MDWamp?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        MDWampTransportWebSocket *websocket = [[MDWampTransportWebSocket alloc] initWithServer:[NSURL URLWithString:@"ws://localhost:8080/ws"] protocolVersions:@[kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json]];
//        
//        _wamp = [[MDWamp alloc] initWithTransport:websocket realm:@"realm1" delegate:self];
        
        print("Attempting to connect...")
        socket = MDWampTransportWebSocket(server:NSURL(string: URL), protocolVersions:[kMDWampProtocolWamp2msgpack, kMDWampProtocolWamp2json])
        session = MDWamp(transport: socket, realm: "pd.damouse", delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mdwamp(wamp: MDWamp!, sessionEstablished info: [NSObject : AnyObject]!) {
        print("Session Established!")
    }
    
    func mdwamp(wamp: MDWamp!, closedSession code: Int, reason: String!, details: [NSObject : AnyObject]!) {
        print("Session Closed!")
    }

}

