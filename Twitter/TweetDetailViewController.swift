//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by XXY on 16/2/27.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userhandle: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var numRetweet: UILabel!
    
    @IBOutlet weak var numLike: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBAction func retweetAction(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet.id!, params: nil) { (error) -> () in
            self.tweet.retweets = self.tweet.retweets! + 1
            self.numRetweet.text = "\(self.tweet.retweets!)"
        }
    }
    
    @IBAction func likeAction(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet.id!, params: nil) { (error) -> () in
            self.tweet.likes = self.tweet.likes! + 1
            self.numLike.text = "\(self.tweet.likes!)"
        }

    }
    

    let currentUser = User.currentUser

    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = tweet.user!.name
        userhandle.text = "@\(tweet.user!.screenname!)"
        content.text = tweet.text
        profilePic.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components([.Hour, .Minute, .Month, .Day, .Year], fromDate: tweet.createdAt!)
        time.text = "\(comp.hour % 12):\(comp.minute) PM - \(comp.month)/\(comp.day)/\(comp.year)"
        
        numRetweet.text = "\(tweet.retweets!)"
        numLike.text = "\(tweet.likes!)"
        
        retweetLabel.text = "retweets"
        likeLabel.text = "likes"

        print(tweet)


    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let replyViewController = segue.destinationViewController as! ReplyViewController
        replyViewController.tweet = tweet
    }
}