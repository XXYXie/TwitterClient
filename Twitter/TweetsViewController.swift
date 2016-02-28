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
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! TweetDetailViewController
        
        detailViewController.tweet = tweet
        
        print("prepare for segue called")
        
    }
    
    

}
