//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Dylan Huang on 2/28/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    var cell: TweetCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.setImageWithURL(NSURL(string: cell.tweet.user!.profileUrlString!)!)
        nameLabel.text = "@\(cell.tweet.user!.screenname!)"
        followersCountLabel.text = String(cell!.tweet!.followersCount!)
        followingCountLabel.text = String(cell!.tweet!.followingCount!)
        tweetCountLabel.text = String(cell!.tweet!.tweetCount!)
        print(cell.tweet.text)
        
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
