//
//  comment.swift
//  PetOye
//
//  Created by Ameya Vichare on 01/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol commentCellDelegator {
    func showProf(showTag: Int)
}

class comment_cell: UITableViewCell {

    var delegate: commentCellDelegator!

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var comment_message: UILabel!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var usernamePress: UIButton!
    
    
    @IBAction func usernameBut(sender: AnyObject) {
        
        //("yes")
        self.delegate.showProf(usernamePress.tag)
    }

}
