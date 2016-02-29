//
//  PostViewController.swift
//  Twitter
//
//  Created by Dylan Huang on 2/28/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    var charactersLeft: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLabel.text = "@\(User.currentUser!.screenname!)"
        profileView.setImageWithURL(NSURL(string: (User.currentUser?.profileUrlString)!)!)
        nameLabel.text = User.currentUser!.name! as! String
        profileView.layer.cornerRadius = 1
        profileView.clipsToBounds = true
        postTextField.becomeFirstResponder()
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func postButton(sender: AnyObject) {
        TwitterClient.sharedInstance.postTweet(postTextField.text, success: {}, failure: {(error: NSError) -> () in
            print(error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        charactersLeft = (150 - postTextField.text!.characters.count)
        countLabel.text = String(charactersLeft)
        print("change")
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
