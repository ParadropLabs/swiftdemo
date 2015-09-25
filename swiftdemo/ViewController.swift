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
    var session: FastSession?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = FastSession(pdid: "pd.damouse")
        session?.connect()
    }
}


/////////////////////////////////
// Local Session
/////////////////////////////////

class FastSession: RiffleSession {
    override func onJoin() {
        
        subscribe("pd.damouse.quick/sub") { () -> () in
            print("Sub recieved")
        }
        
        call("pd.damouse.quick/hello", args:"hello!", "you cake")
    }
}