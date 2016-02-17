//
//  ViewController.swift
//  Twitter
//
//  Created by XXY on 16/2/15.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil{
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else{
                // handle login error
            }
        }


    }

}