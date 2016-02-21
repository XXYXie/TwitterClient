//
//  TweetCell.swift
//  Twitter
//
//  Created by XXY on 16/2/20.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userhandle: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var replyIcon: UIImageView!
    
    @IBOutlet weak var retweetIcon: UIImageView!
    
    @IBOutlet weak var likeIcon: UIImageView!
    
    @IBOutlet weak var numRetweet: UILabel!
    
    @IBOutlet weak var numLike: UILabel!
   
    @IBOutlet weak var time: UILabel!
    
    let currentUser = User.currentUser
    
    var tweet: Tweet!{
        didSet {
            username.text = tweet.user!.name
            userhandle.text = "@\(tweet.user!.screenname!)"
            content.text = tweet.text
            profilePic.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            
            let calendar = NSCalendar.currentCalendar()
            let comp = calendar.components([.Month, .Day, .Year], fromDate: tweet.createdAt!)
            
            time.text = "\(comp.month)/\(comp.day)/\(comp.year)"
            numRetweet.text = String(tweet.retweets)
            numLike.text = String(tweet.likes)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}
