//
//  Tweet.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/22/16.
//  Copyright © 2016 Daniel Zhang All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var time: String?
    var InitTime: Int?
    var timeSince: String!
    var user: User?
    var favoritesCount: Int?
    var retweetCount: Int?
    var retweeted: Int!
    var favorited: Int!
    var id: String!
    var followersCount: Int!
    var followingCount: Int!
    var tweetCount: Int!
    
    
    init(dictionary: NSDictionary){
        tweetCount = dictionary["user"]!["statuses_count"] as? Int
        followingCount = dictionary["user"]!["friends_count"] as? Int
        followersCount = dictionary["user"]!["followers_count"] as? Int
        id = dictionary["id_str"] as? String
        retweeted = Int((dictionary["retweeted"] as? Int)!)
        favorited = Int((dictionary["favorited"] as? Int)!)
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
            timestamp = formatter.dateFromString(timestampString)
        }
        let now = NSDate()
        let then = timestamp
        InitTime = Int(now.timeIntervalSinceDate(then!))
        
        if InitTime >= 86400 {
            timeSince = String(InitTime! / 86400)+"d"
        }
        if (3600..<86400).contains(InitTime!) {
            timeSince = String(InitTime!/3600)+"h"
        }
        if (60..<3600).contains(InitTime!) {
            timeSince = String(InitTime!/60)+"m"
        }
        if InitTime < 60 {
            timeSince = String(InitTime!)+"s"
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
       var tweets = [Tweet]()
    
    for dictionary in dictionaries {
        let tweet = Tweet(dictionary: dictionary)
    
        tweets.append(tweet)
    }
    return tweets
    
    }

}
