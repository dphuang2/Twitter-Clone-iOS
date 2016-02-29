//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Dylan Huang on 2/28/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var replyTextField: UITextField!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    var favorited: Int!
    var retweeted: Int!
    var cell: TweetCell!
    var indexPath: NSIndexPath!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
//        replyTextField.text = "@\(tweet.user!.screenname!) "
        print(indexPath!)
        super.viewDidLoad()
        profileView.setImageWithURL(NSURL(string: tweet.user!.profileUrlString!)!)
        usernameLabel.text = tweet.user!.name as? String
        nameLabel.text = "@\(tweet.user!.screenname!)"
        tweetLabel.text = tweet.text as? String
        timeLabel.text = tweet.timeSince
        retweetLabel.text = "\(tweet.retweetCount!)"
        favoriteLabel.text = "\(tweet.favoritesCount!)"
        favorited = cell.favorited!
        retweeted = cell.retweeted!
        var retweetsCount: Int
        if(retweeted == 1){
            retweetsCount = tweet.retweetCount! + 1
            retweetLabel.text = "\(retweetsCount)"
            retweetLabel.textColor = UIColor.redColor()
        }
        else{
            retweetsCount = tweet.retweetCount!
            retweetLabel.text = "\(retweetsCount)"
            retweetLabel.textColor = UIColor.blackColor()
        }
        var favoritesCount: Int
        if(favorited == 1){
            favoritesCount = tweet.favoritesCount! + 1
            favoriteLabel.text = "\(favoritesCount)"
            favoriteLabel.textColor = UIColor.redColor()
        }
        else{
            favoritesCount = tweet.favoritesCount!
            favoriteLabel.text = "\(favoritesCount)"
            favoriteLabel.textColor = UIColor.blackColor()
        }
        
    }

    
    @IBAction func favoriteButton(sender: AnyObject) {
        var favoritesCount: Int
        if(cell.favorited == 1){
            TwitterClient.sharedInstance.unfavoriteTweet(tweet.id, success: {}, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
            })
            cell.favorited = 0
            favoritesCount = tweet.favoritesCount!
            favoriteLabel.text = "\(favoritesCount)"
            favoriteLabel.textColor = UIColor.blackColor()
        }
        else{
            TwitterClient.sharedInstance.favoriteTweet(tweet.id, success: {}, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
            })
            cell.favorited = 1
            favoritesCount = tweet.favoritesCount! + 1
            favoriteLabel.text = "\(favoritesCount)"
            favoriteLabel.textColor = UIColor.redColor()
        }
    }
    
    @IBAction func retweetButton(sender: AnyObject) {
        var retweetsCount: Int
        if(cell.retweeted == 1){
            print("you just un-retweeted this tweet")
            cell.retweeted = 0
            retweetsCount = tweet.retweetCount!
            retweetLabel.text = "\(retweetsCount)"
            retweetLabel.textColor = UIColor.blackColor()
        }
        else{
            print("you just retweeted this tweet")
            cell.retweeted = 1
            retweetsCount = tweet.retweetCount! + 1
            retweetLabel.text = "\(retweetsCount)"
            retweetLabel.textColor = UIColor.redColor()
        }
    }
    
    @IBAction func replyButton(sender: AnyObject) {
        TwitterClient.sharedInstance.replyTweet(replyTextField.text, id: tweet.id, success: {}, failure: {(error: NSError) -> () in
            print(error.localizedDescription)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TweetsViewController.indexPath = indexPath
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let tweetsViewController = segue.destinationViewController as! TweetsViewController
        tweetsViewController.indexPath = indexPath
        print(indexPath)
        
        
    }
    */
    

}
