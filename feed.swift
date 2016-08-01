//
//  feed.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol FeedCellDelegate {
    func feedCell(didPressUsernameButtonInCell: feed)
}


class feed: UITableViewCell {


    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var likecount: UILabel!
    @IBOutlet weak var commentcount: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var postedImage: UIImageView!

    @IBOutlet weak var profilePicPress: UIButton!
    @IBOutlet weak var usernamePress: UIButton!
    @IBOutlet weak var reportPress: UIButton!
    @IBOutlet weak var likePress: UIButton!

    @IBOutlet weak var commentPress: UIButton!
    @IBOutlet weak var share1Press: UIButton!
    @IBOutlet weak var share2Press: UIButton!
    @IBOutlet weak var imageTap: UIButton!
    @IBOutlet weak var like_selected: UIImageView!
    
    var delegate: FeedCellDelegate?
    
    //var userNameArray:[String]?
    
    @IBAction func usernameBut(sender: AnyObject) {
        //print(usernamePress.tag)
        //delegate?.feedCell(self)
        //print(userNameArray?[usernamePress.tag])
        
        let data = userDefault.objectForKey("storedPostUserId") as! [String]
        print(data[usernamePress.tag])
        var showProfileId = data[usernamePress.tag]
        
        
        
    }
    
    @IBAction func profilePicBut(sender: AnyObject) {
        let data = userDefault.objectForKey("storedPostUserId") as! [String]
        print(data[usernamePress.tag])
        var showProfileId = data[usernamePress.tag]
    }

    @IBAction func reportBut(sender: AnyObject) {
        
        
    }
    
    @IBAction func likeBut(sender: AnyObject) {
        
        let data = userDefault.objectForKey("storedPostId") as! [String]
        print(data[likePress.tag])
        print(likePress.tag)
        var likedPostId = data[likePress.tag]
        var buttonId = Int(likedPostId)
        
        //liking a post API call
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(likedPostId)/like")!)
        request.HTTPMethod = "POST"
        let postString = "uid=42"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                //print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
            {
                //set like buttonimage to filled
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(responseString)
                
                //let json = JSON(data: data!)
                
                //let likedC = json["like_count"].stringValue
                // pop up to show liked post and setting like image
                
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                //print("statusCode should be 200, but is \(httpStatus.statusCode)")
                //print(response!)
                let json = JSON(data: data!)
                let bug = json["errors"].stringValue
                // pop up showing already liked and set image to filled
                if bug == "already liked"
                {
                    // pop up showing already liked and set image to filled
                    print("already liked")
                    //print(buttonId!)
                    //print(self.likePress.tag)
                    self.likePress.viewWithTag(self.likePress.tag)?.userInteractionEnabled = false
                    //self.like_selected.hidden = false
                    //self.like_selected.hidden = false
                    //self.likePress.viewWithTag(self.likePress.tag)?.hidden = true
                }
                else {
                    print("try again later")
                }
            }
            
            //var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            
        }
        task.resume()

    }

    
    @IBAction func imageTapBut(sender: AnyObject) {
        
        
    }
    
   
    @IBAction func commentBut(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func share1But(sender: AnyObject) {
    }
    
    @IBAction func share2But(sender: AnyObject) {
    }
    
    
    
    
    
    
}
