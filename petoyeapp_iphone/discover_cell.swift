//
//  discover_cell.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
protocol discoverDelegate {
    func follow(discoverTag: Int)
    func showProf(showTag: Int)
}


class discover_cell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var owner_type: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var followedBut: UIButton!
    @IBOutlet weak var toFollowBut: UIButton!
    var delegate: discoverDelegate?
    
    @IBOutlet weak var usernamePress: UIButton!
    
    
    @IBAction func to_follow(sender: AnyObject) {
        
        self.delegate?.follow(toFollowBut.tag)
        
    }
    
    
    @IBAction func followed(sender: AnyObject) {
        //toFollowBut.tag
    }
    
    @IBAction func usernameBut(sender: AnyObject) {
        
        self.delegate?.showProf(usernamePress.tag)
        
    }
    
    
}
