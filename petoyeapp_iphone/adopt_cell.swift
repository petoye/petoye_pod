//
//  adopt_cell.swift
//  PetOye
//
//  Created by Ameya Vichare on 31/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

protocol adoptCellDelegator {
    
    func share(cell_id: Int)
}

class adopt_cell: UITableViewCell {
    
    var delegate: adoptCellDelegator!

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var pet_info: UILabel!
    
    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var shareBut: UIButton!
    
    
    
    @IBAction func share(sender: AnyObject) {
        
        print("shared")
        
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        //print(indexPath.row)
        self.delegate.share(indexPath.row)
    }


}
