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
    
    var delegate: FeedCellDelegate?
    
    //var userNameArray:[String]?
    
    @IBAction func usernameBut(sender: AnyObject) {
        //print(usernamePress.tag)
        //delegate?.feedCell(self)
        //print(userNameArray?[usernamePress.tag])
        
        let data = userDefault.objectForKey("storedPostUserId") as! [String]
        print(data[usernamePress.tag])
        var showProfileId = data[usernamePress.tag]
        
        //showing userProfile
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/3/nearbyfeeds")!)
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(responseString)
            
            let json = JSON(data: data!)
            
            for item in json["feeds"].arrayValue {
                


                    
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        
                    })
                    
                    
                
                
            }
 
            
            
            //for now doing nearby feeds
        }
        task.resume()
        
        
    }
    
}
