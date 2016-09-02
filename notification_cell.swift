//
//  notification_cell.swift
//  PetOye
//
//  Created by Ameya Vichare on 05/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol notifDelegate {
    func showProf(showTag: Int)
}

class notification_cell: UITableViewCell {
    
    var delegate: notifDelegate!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var followNotif: UILabel!
    
    @IBOutlet weak var usernamePress: UIButton!
    
    @IBAction func usernameBut(sender: AnyObject) {
        
        self.delegate.showProf(usernamePress.tag)
    }
    
}
