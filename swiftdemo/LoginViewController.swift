//
//  LoginViewController.swift
//  swiftdemo
//
//  Created by Mickey Barboi on 9/27/15.
//  Copyright © 2015 paradrop. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textfieldName: UITextField!

    @IBAction func login(sender: AnyObject) {
        if textfieldName.text == "" {
            let alert = UIAlertController(title: "Error", message: "Name cant be empty", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("message") as! ViewController
        controller.username = textfieldName.text!
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
