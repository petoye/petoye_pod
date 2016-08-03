//
//  discover_cell.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
protocol discoverDelegate {
    func reloadDiscover()
}


class discover_cell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var owner_type: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var followedBut: UIButton!
    @IBOutlet weak var toFollowBut: UIButton!
    var delegate: discoverDelegate?
    
    @IBAction func to_follow(sender: AnyObject) {
        //self.followedBut.viewWithTag(toFollowBut.tag)?.hidden = false
        print(toFollowBut.tag)
        self.toFollowBut.viewWithTag(toFollowBut.tag)?.hidden = true
        self.delegate?.reloadDiscover()
        
        //let data = userDefault.objectForKey("storedPostUserId") as! [String]
        //print(data[toFollowBut.tag])
        //var FollowedUser_Id = data[toFollowBut.tag]
        //userDefault.setObject(FollowedUser_Id, forKey: "storedFollowedUserId")
        
        // following a user api call
        
 
        let my_id = 1//userDefault.objectForKey("id")
        //print("u_id=\(u_id)")
        let his_id = userDefault.objectForKey("storedUserIds") as! [String]
        let hisid = his_id[toFollowBut.tag]
        print(hisid)
        
        
        // add a comment api call
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/\(my_id)/follow")!)
        request.HTTPMethod = "POST"
        let postString = "hisid=\(hisid)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
            {
                // show followed
                //self.toFollowBut.viewWithTag(self.toFollowBut.tag)?.hidden = true
                // pop up followed
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
            
            
        }
        task.resume()

        
    }
    
    
    @IBAction func followed(sender: AnyObject) {
        //toFollowBut.tag
    }
    
    
}
