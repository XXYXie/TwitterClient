//
//  TweetsViewController.swift
//  Twitter
//
//  Created by XXY on 16/2/16.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var reply: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    

    
    var tweets: [Tweet]?
    
    let tapProfileDetail = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            // Remember to reload the data!!
            self.tableView.reloadData()
        })
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ProfileDetailSegue:", name: "profileDetailNotification", object: nil)
        
    }

    let currentUser = User.currentUser
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
           
        } else {
            return 0
        }
    }
   
    func profileDetailSegue(gesture: UITapGestureRecognizer) {
        let tweetCell = gesture.view?.superview?.superview as! TweetCell
        performSegueWithIdentifier("ProfileDetailSegue", sender: tweetCell.tweet!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: "profileDetailSegue:")
        cell.profilePic.userInteractionEnabled = true
        cell.profilePic.addGestureRecognizer(gestureRecognizer)
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }
    
 
    @IBAction func retweetAction(sender: AnyObject) {
        
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let path = tweet.id
        
        TwitterClient.sharedInstance.retweet(path!, params: nil) { (error) -> () in
            print("Retweeting")
            tweet.retweets = tweet.retweets! + 1
            self.tableView.reloadData()
        }

    }
    
    @IBAction func likeAction(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        
        let path = tweet.id
        
        TwitterClient.sharedInstance.favorite(path!, params: nil) { (error) -> () in
            print("Liking")
            tweet.likes = tweet.likes! + 1
            self.tableView.reloadData()
        }

    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    // Remember to prepare for segue!!! Otherwise no data is transferred to TweetDetailViewController.
    // Prepare for segue for TweetDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "TweetDetailSegue"){
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailViewController = segue.destinationViewController as! TweetDetailViewController
            detailViewController.tweet = tweet
        }
        if(segue.identifier == "ProfileDetailSegue"){
            let tweet = sender as! Tweet
            let profileDetailViewController = segue.destinationViewController as! ProfileDetailViewController
            profileDetailViewController.user = tweet.user
            profileDetailViewController.tweet = tweet
            
        }
        if(segue.identifier == "ComposeSegue"){
            if let createTweet = sender as? Tweet {
                let composeViewController = segue.destinationViewController as! ComposeNewViewController
                composeViewController.composeTweet = createTweet
            }

        }

        
        print("prepare for segue called")
        
    }
    
    
    // Prepare for segue for ProfileDetailViewController
    

}
