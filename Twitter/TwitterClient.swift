//
//  TwitterClient.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/22/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager
{
    

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "ifrPb6A9YEONrViS6OaRLjCyP", consumerSecret: "yUlJG6baPag4F4f6XtIvuvJ8orLN0Xlk6lKoBCu0I8UYsmUhC3")
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterduncan://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("I got a token!")
            
        let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
        UIApplication.sharedApplication().openURL(url)
            
        }) {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }

    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath(("oauth/access_token"), method: "POST",
            requestToken: requestToken, success: {(accessToken:
                BDBOAuth1Credential!) -> Void in
                
                self.currentAccount({(user: User) -> () in
                    self.loginSuccess?()
                    User.currentUser = user
                    }, failure: {(error: NSError) -> () in
                        self.loginFailure?(error)
                })
                
                
            }) {(error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

        
    }
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            //print("name: \(user["name"])")
            
            let user = User(dictionary: userDictionary)
            success(user)
           
            
            },failure:  {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            
            }, failure: {(task:NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func postTweet(text: String!, success: () -> (), failure: (NSError) -> ()){
        POST("1.1/statuses/update.json?status=\(text)", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("you posted a tweet")
            
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func replyTweet(text: String!, id: String!, success: () -> (), failure: (NSError) -> ()){
        POST("1.1/statuses/update.json?status=\(text)&in_reply_to_status_id=\(id)", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("you replied to a tweet")
            print("1.1/statuses/update.json?status=\(text)&in_reply_to_status_id=\(id)")
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func favoriteTweet(id: String!, success: () -> (), failure: (NSError) -> ()){
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("you favorited a tweet")
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func unfavoriteTweet(id: String!, success: () -> (), failure: (NSError) -> ()){
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: {(task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("you unfavorited a tweet")
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }

    
    
    
}
