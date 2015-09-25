//
//  ViewController.swift
//  swiftdemo
//
//  Created by Mickey Barboi on 9/24/15.
//  Copyright (c) 2015 paradrop. All rights reserved.
//

import UIKit

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
        
        // Sub and Register
        subscribe("pd.damouse.quick/cpub", callback: clientPub)
        register("pd.damouse.quick/ccall", callback: clientCall)
        
        // Pub and Call
        call("pd.damouse.quick/scall", args:"hello!", "you cake")
        publish("pd.damouse.quick/spub", args: [])
    }
    
    func clientPub(args: AnyObject...) {
        print("Sub recieved: ", args)
    }
    
    func clientCall(args: AnyObject...) {
        
    }
}