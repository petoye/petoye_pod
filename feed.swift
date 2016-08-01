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
        
        
        
    }
    
    @IBAction func profilePicBut(sender: AnyObject) {
        let data = userDefault.objectForKey("storedPostUserId") as! [String]
        print(data[usernamePress.tag])
        var showProfileId = data[usernamePress.tag]
    }

    @IBAction func reportBut(sender: AnyObject) {
        
        
    }
    
    @IBAction func likeBut(sender: AnyObject) {
        
        
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
