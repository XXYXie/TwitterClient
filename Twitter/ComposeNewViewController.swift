//
//  ComposeNewViewController.swift
//  Twitter
//
//  Created by XXY on 16/2/28.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ComposeNewViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var beforeType: UILabel!
    
    @IBOutlet weak var textTweet: UITextView!
    
    var composeTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textTweet.delegate = self
        // Show Keyboard
        textTweet.becomeFirstResponder()
 
        textTweet.text = ""
        
        let currentUser = User.currentUser!
        profilePic.setImageWithURL(NSURL(string: currentUser.profileImageUrl!)!)
    }
    

    override func viewDidDisappear(animated: Bool) {
        textTweet.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Cancel sending tweet.")
        }
    }
    
    // On tap, hid keyboard
    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func sendTweet(sender: AnyObject) {
      
        TwitterClient.sharedInstance.status(textTweet.text, replyId: 0, params: nil){(error) -> () in
        }
    
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Dismissed")
        }

    }


}
