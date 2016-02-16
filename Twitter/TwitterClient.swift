//
//  TwitterClient.swift
//  Twitter
//
//  Created by XXY on 16/2/15.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "OkfTuR7BF6SkLwe3s2nKUqkK9"
let twitterConsumerSecret = "ESQJLg6dn89J2yKRHTZbbFsypUtIguhiEU1BTKFVLVIjVFQQuA"
let twitterBaseURL = NSURL(string:"https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret:
                twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
