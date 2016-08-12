//
//  BackTableVC.swift
//  PetOye
//
//  Created by Ameya Vichare on 12/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    
    var TableArray = [String]()
    
    @IBOutlet var hamTable: UITableView!
    
    
    override func viewDidLoad() {
        
        hamTable.tableFooterView = UIView(frame: CGRectZero)
        
        TableArray = ["Home","Adoption","Pet Breeds","Kennels","Shelters","Groomers","Trainers","Events","Settings","About us","App Info"]
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ham_cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
    }
}
