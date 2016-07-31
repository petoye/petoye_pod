//
//  feed.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

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
    
    
}
