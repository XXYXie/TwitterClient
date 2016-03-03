//
//  ReplyViewController.swift
//  Twitter
//
//  Created by XXY on 16/3/2.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var textBox: UITextView!
    var tweet: Tweet!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textBox.text = "@ \(tweet.name!)"
        textBox.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Cancel reply.")
        }
    }
    
    @IBAction func reply(sender: AnyObject) {
        TwitterClient.sharedInstance.status(textBox.text, replyId: 0, params: nil){(error) -> () in
        }
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("Reply")
        }

    }
    
}