//
//  TableViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var feedTable: UITableView!
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        feedTable.delegate = self
        feedTable.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("feed", forIndexPath: indexPath) as! feed
            //cell.textLabel?.text = "TEST"
            
            cell.postedImage.image = UIImage(named: "PetOyeGreen60pt@2x.png")
            cell.username.text = "Hello Hello!"
            cell.message.text = "so cute"
            return cell
            
    }
}