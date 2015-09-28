//
//  ViewController.swift
//  swiftdemo
//
//  Created by Mickey Barboi on 9/24/15.
//  Copyright (c) 2015 paradrop. All rights reserved.
//

import UIKit
import Riffle

class ViewController: UIViewController, RiffleDelegate {
    //var session: FastSession?
    var session: RiffleSession?
    var username: String?
    

    @IBOutlet weak var textfieldInput: UITextField!
    @IBOutlet weak var textfieldMessages: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //session = FastSession(pdid: "pd.damouse")
        //session?.connect()
        
        session = RiffleSession(pdid: "pd.damouse.rschat." + username!)
        session!.delegate = self
        session!.connect()
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        let message = textfieldInput.text!
        
        textfieldMessages.text = textfieldMessages.text + message + "\n"
        
        textfieldInput.resignFirstResponder()
        textfieldInput.text = ""
        
        // send the message
        session!.publish("pd.damouse.rschat/message", args: ["pd.damouse.rschat." + username!, message])
        print("Sent Message")
    }
    
    
    func newMessage(contents: AnyObject...) {
        let a = contents[0] as! NSArray
        let b = a[0] as! NSArray
        
        let sender = b.objectAtIndex(0) as! String
        let message = b.objectAtIndex(1) as! String
        
        textfieldMessages.text = sender + ": " + message + "\n\n" + textfieldMessages.text
    }
    
    func onJoin() {
        session!.subscribe("pd.damouse.rschat/message", callback: newMessage)
        print("Finished subscribing")
    }
    
    func onLeave() {
        
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