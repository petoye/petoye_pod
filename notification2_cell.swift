//
//  notification2_cell.swift
//  PetOye
//
//  Created by Ameya Vichare on 05/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol notif2Delegate {
    func show(showTag: Int)
    func postShow(showTag: Int)
}


class notification2_cell: UITableViewCell {

    var delegate: notif2Delegate!
    
    @IBOutlet weak var profilePic: UIImageView!
 
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var c_l_notif: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postImagePress: UIButton!
    
    @IBOutlet weak var usernamePress: UIButton!
    
    @IBAction func usernameBut(sender: AnyObject) {
        
        self.delegate.show(usernamePress.tag)
        
    }
    
    @IBAction func postPress(sender: AnyObject) {
        
        self.delegate.postShow(postImagePress.tag)
        
    }
}
