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
        
        TableArray = ["Home","Adoption","Pet Breeds","Settings","About us","Why PetOye?","","","","","",""]
        
        var first_name = "Ameya"//NSUserDefaults.standardUserDefaults().stringForKey("first_name")!
        hello.title = "Hello, \(first_name)"
        
        //self.prefersStatusBarHidden()
        
        //UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //self.setNeedsStatusBarAppearanceUpdate()
        
        navigationController?.prefersStatusBarHidden()
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    /*
    
    override func prefersStatusBarHidden() -> Bool {
        
            return true
        
    }
 
 */
    
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
            cell.imageView?.image = UIImage(named: "settings_ham.png")
        }
        else if indexPath.row == 4 {
            cell.imageView?.image = UIImage(named: "about.png")
        }
        else if indexPath.row == 5 {
            cell.imageView?.image = UIImage(named: "petoye.png")
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("hamToHome", sender: self)
        }
        else if indexPath.row == 1 {
            self.performSegueWithIdentifier("hamToAdopt", sender: self)
        }
        else if indexPath.row == 2 {
            self.performSegueWithIdentifier("hamToBreeds", sender: self)
        }
        else if indexPath.row == 3 {
            self.performSegueWithIdentifier("hamToSettings", sender: self)
        }
        else if indexPath.row == 4 {
            self.performSegueWithIdentifier("hamToAbout", sender: self)
        }
        else if indexPath.row == 5 {
            self.performSegueWithIdentifier("hamToWhy", sender: self)
        }
    }
    
}
