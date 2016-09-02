//
//  like_cell.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol likeCellDelegator {
    func showProf(showTag: Int)
}

class like_cell: UITableViewCell {
    
    var delegate: likeCellDelegator!

    @IBOutlet weak var profilePic: UIImageView!

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var usernamePress: UIButton!
    
    @IBAction func usernameBut(sender: AnyObject) {
        
        self.delegate.showProf(usernamePress.tag)
        
    }
    
    
}
