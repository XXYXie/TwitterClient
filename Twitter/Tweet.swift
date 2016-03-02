//
//  Tweet.swift
//  Twitter
//
//  Created by XXY on 16/2/16.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var name: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweets: Int?
    var likes: Int?
    var id: Int?
    
    var isRetweeted: Bool?
    var isFavorited: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        retweets = dictionary["retweet_count"] as? Int
        likes = dictionary["favorite_count"] as? Int
        
        id = dictionary["id"] as? Int
        // Time format
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        name = dictionary["user"]!["name"] as? String
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            // create new tweet based on the array
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
