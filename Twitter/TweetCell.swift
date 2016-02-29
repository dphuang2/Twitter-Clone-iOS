//
//  TweetCell.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/22/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    var favorited: Int!
    var retweeted: Int!
    
 
    
    var tweet: Tweet! {
        didSet {
        profileView.setImageWithURL(NSURL(string: tweet.user!.profileUrlString!)!)
        usernameLabel.text = tweet.user!.name as? String
        nameLabel.text = "@\(tweet.user!.screenname!)"
        tweetLabel.text = tweet.text as? String
        timeLabel.text = tweet.timeSince
        retweetLabel.text = "\(tweet.retweetCount!)"
        favoriteLabel.text = "\(tweet.favoritesCount!)"
        favorited = tweet.favorited!
        retweeted = tweet.retweeted!
            
            
        }
    }
    @IBAction func retweetButton(sender: AnyObject) {
        var retweetsCount: Int
        if(retweeted == 1){
            print("you just un-retweeted this tweet")
            retweeted = 0
            retweetsCount = tweet.retweetCount!
            retweetLabel.text = "\(retweetsCount)"
            retweetLabel.textColor = UIColor.blackColor()
        }
        else{
            print("you just retweeted this tweet")
            retweeted = 1
            retweetsCount = tweet.retweetCount! + 1
            retweetLabel.text = "\(retweetsCount)"
            retweetLabel.textColor = UIColor.redColor()
        }
    }
    @IBAction func favoriteButton(sender: AnyObject) {
        var favoritesCount: Int
        if(favorited == 1){
            TwitterClient.sharedInstance.unfavoriteTweet(tweet.id, success: {}, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
            })
            favorited = 0
            favoritesCount = tweet.favoritesCount!
            favoriteLabel.text = "\(favoritesCount)"
            favoriteLabel.textColor = UIColor.blackColor()
        }
        else{
            TwitterClient.sharedInstance.favoriteTweet(tweet.id, success: {}, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
            })
            favorited = 1
            favoritesCount = tweet.favoritesCount! + 1
            favoriteLabel.text = "\(favoritesCount)"
            favoriteLabel.textColor = UIColor.redColor()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileView.layer.cornerRadius = 3
        profileView.clipsToBounds = true
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
