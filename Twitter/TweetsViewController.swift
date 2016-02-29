//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Daniel Zhang on 2/22/16.
//  Copyright © 2016 Daniel Zhang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    


    var tweets: [Tweet]!
    static var indexPath: NSIndexPath!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120 // Used for scroll height dimension
        TwitterClient.sharedInstance.homeTimeline({(tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
//            for tweet in tweets {
//                print(tweet.text)
//            }
            }, failure: {(error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets == nil {
            return 0
        } else {
            return tweets!.count
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = TweetsViewController.indexPath
        
        if((indexPath) != nil){
            print(indexPath!)
            var cell = tableView.cellForRowAtIndexPath(indexPath) as! TweetCell
            var retweetsCount: Int
            if(cell.retweeted == 1){
                retweetsCount = cell.tweet.retweetCount! + 1
                cell.retweetLabel.text = "\(retweetsCount)"
                cell.retweetLabel.textColor = UIColor.redColor()
            }
            else{
                retweetsCount = cell.tweet.retweetCount!
                cell.retweetLabel.text = "\(retweetsCount)"
                cell.retweetLabel.textColor = UIColor.blackColor()
            }
            var favoritesCount: Int
            if(cell.favorited == 1){
                favoritesCount = cell.tweet.favoritesCount! + 1
                cell.favoriteLabel.text = "\(favoritesCount)"
                cell.favoriteLabel.textColor = UIColor.redColor()
            }
            else{
                favoritesCount = cell.tweet.favoritesCount!
                cell.favoriteLabel.text = "\(favoritesCount)"
                cell.favoriteLabel.textColor = UIColor.blackColor()
            }
            
            
        } else {
            print("indexPath is nil")
        }
        

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.destinationViewController.title! == "ProfileViewController"){
            let cell = sender?.superview!!.superview as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.cell = cell
        }
        if(segue.destinationViewController.title! == "DetailsViewController"){
            let cell = sender as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailViewController = segue.destinationViewController as! DetailsViewController
            detailViewController.tweet = tweet
            detailViewController.cell = cell
            detailViewController.indexPath = indexPath
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
