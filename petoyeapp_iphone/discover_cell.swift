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
        self.followedBut.viewWithTag(toFollowBut.tag)?.hidden = false
        //self.toFollowBut.hidden = true
        self.toFollowBut.viewWithTag(toFollowBut.tag)?.hidden = true
        self.delegate?.reloadDiscover()
        
        //let data = userDefault.objectForKey("storedPostUserId") as! [String]
        //print(data[toFollowBut.tag])
        //var FollowedUser_Id = data[toFollowBut.tag]
        //userDefault.setObject(FollowedUser_Id, forKey: "storedFollowedUserId")
        
        
    }
    
    
    @IBAction func followed(sender: AnyObject) {
        //toFollowBut.tag
    }
    
    
}
