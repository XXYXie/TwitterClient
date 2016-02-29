//
//  ProfileDetailViewController.swift
//  Twitter
//
//  Created by XXY on 16/2/27.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userhandle: UILabel!
    
    @IBOutlet weak var numTweets: UILabel!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    
    @IBOutlet weak var numFollowing: UILabel!
    
    @IBOutlet weak var numFollowers: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var profileDescription: UILabel!
    
    var user: User!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = tweet.user!.name
        userhandle.text = "@\(user!.screenname!)"
        profileDescription.text = user.tagline
        profilePic.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        numTweets.text = "\(tweet.user!.numTweets)"
        numFollowers.text = "\(tweet.user!.numFollowers)"
        numFollowing.text = "\(tweet.user!.numFollowing)"
        
        if user.profileBackgroundUrl != nil {
            headerImage.setImageWithURL(NSURL(string: user!.profileBackgroundUrl!)!)
        } else {
            headerImage.backgroundColor = UIColor.blackColor()
        }
           // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
