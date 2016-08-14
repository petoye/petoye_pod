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
    
    @IBOutlet weak var hello: UIBarButtonItem!
    @IBOutlet var hamTable: UITableView!

    
    
    override func viewDidLoad() {
        
        hamTable.tableFooterView = UIView(frame: CGRectZero)
        
        TableArray = ["Home","Adoption","Pet Breeds","Pet Vets","Groomers","Trainers","Day Care","Events","Settings","About us","Why PetOye?"]
        
        var first_name = "Vaibhav"//NSUserDefaults.standardUserDefaults().stringForKey("first_name")!
        hello.title = "Hello, \(first_name)"
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ham_cell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = TableArray[indexPath.row]
        
        if indexPath.row == 0 {
        cell.imageView?.image = UIImage(named: "home.png")
        }
        else if indexPath.row == 1 {
            cell.imageView?.image = UIImage(named: "adoption.png")
        }
        else if indexPath.row == 2 {
            cell.imageView?.image = UIImage(named: "petbreeds.png")
        }
        else if indexPath.row == 3 {
            cell.imageView?.image = UIImage(named: "vet.png")
        }
        else if indexPath.row == 4 {
            cell.imageView?.image = UIImage(named: "groom.png")
        }
        else if indexPath.row == 5 {
            cell.imageView?.image = UIImage(named: "training.png")
        }
        else if indexPath.row == 6 {
            cell.imageView?.image = UIImage(named: "kennel.png")
        }
        else if indexPath.row == 7 {
            cell.imageView?.image = UIImage(named: "events.png")
        }
        else if indexPath.row == 8 {
            cell.imageView?.image = UIImage(named: "settings.png")
        }
        else if indexPath.row == 9 {
            cell.imageView?.image = UIImage(named: "about.png")
        }
        else if indexPath.row == 10 {
            cell.imageView?.image = UIImage(named: "petoye.png")
        }
        
        
        return cell
    }
}
