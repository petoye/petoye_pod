//
//  feed.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol MyCustomCellDelegator {
    func report(cell_id: Int)
    func likeIt(likeTag: Int)
    func commentIt(commentTag: Int)
    func likedBy(byTag: Int)
    func shareIt(shareTag: Int)
    func showProfile(userTag: Int)
}




class feed: UITableViewCell {


    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var likecount: UILabel!
    @IBOutlet weak var commentcount: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var postedImage: UIImageView!

    @IBOutlet weak var profilePicPress: UIButton! //remains
    
    @IBOutlet weak var reportPress: UIButton!
    @IBOutlet weak var likePress: UIButton!

    @IBOutlet weak var usernamePress: UIButton!
    @IBOutlet weak var commentPress: UIButton!
    @IBOutlet weak var imageTap: UIButton! //remains
    @IBOutlet weak var like_selected: UIButton!
    @IBOutlet weak var likedBy: UIButton!
    
    @IBOutlet weak var share: UIButton!
    
    //var delegate: FeedCellDelegate?
    var delegate:MyCustomCellDelegator!

    //var userNameArray:[String]?
    
    @IBAction func usernameBut(sender: AnyObject) {
        //print(usernamePress.tag)
        //delegate?.feedCell(self)
        //print(userNameArray?[usernamePress.tag])
        
        //let data = userDefault.objectForKey("storedPostUserId") as! [String]
        //print(data[usernamePress.tag])
        //var showProfileId = data[usernamePress.tag]
        
        //print(usernamePress.tag)
        
        self.delegate.showProfile(usernamePress.tag)
        
        
    }
    
    @IBAction func profilePicBut(sender: AnyObject) {
        //let data = userDefault.objectForKey("storedPostUserId") as! [String]
        //print(data[usernamePress.tag])
        //var showProfileId = data[usernamePress.tag]
    }

    @IBAction func reportBut(sender: AnyObject) {
        
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        //print(indexPath.row)
        self.delegate.report(indexPath.row)
        

    }
    


    
    @IBAction func likeBut(sender: AnyObject) {

        self.delegate.likeIt(likePress.tag)
        
    }

    
    @IBAction func imageTapBut(sender: AnyObject) {
        
        
    }
    
   
    @IBAction func commentBut(sender: AnyObject) {
        
        self.delegate.commentIt(commentPress.tag)
    
    }
    
    @IBAction func likedByBut(sender: AnyObject) {
        
        self.delegate.likedBy(likedBy.tag)

    }
    
    
    @IBAction func shareBut(sender: AnyObject) {
        
        self.delegate.shareIt(share.tag)
    }
    
    
    
    
    
}
