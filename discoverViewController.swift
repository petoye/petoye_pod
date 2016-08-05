//
//  discoverViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit




class discoverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, discoverDelegate {
    
    var username = [String]()
    var ownertype = [String]()
    var breed = [String]()
    var pettype = [String]()
    var user_id = [String]()

    @IBOutlet weak var discoverTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverTable.tableFooterView = UIView(frame: CGRectZero)

        // Do any additional setup after loading the view.
        var u_id = 6
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(u_id)/discover")!)
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(responseString)
            
            let json = JSON(data: data!)
            
            for item in json["users"].arrayValue {
                
                //print(item["username"].stringValue)
                self.username.append(item["username"].stringValue.capitalizedString)
                self.ownertype.append(item["owner_type"].stringValue)
                self.pettype.append(item["pet_type"].stringValue)
                self.breed.append(item["pet_breed"].stringValue)
                self.user_id.append(item["id"].stringValue)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    
                    self.discoverTable.reloadData()
                })
                
            }
            print(self.user_id)
            print(self.username)
            print(self.ownertype)
            print(self.pettype)
            print(self.breed)
        }
        task.resume()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("discover", forIndexPath: indexPath) as! discover_cell
            //cell.textLabel?.text = "TEST"
            cell.delegate = self
            cell.username.text = username[indexPath.row]
            cell.owner_type.text = ownertype[indexPath.row]
            cell.breed.text = breed[indexPath.row]
            //cell.followedBut.hidden = true
            
            cell.profilePic.image = UIImage(named: "dawg.png")
            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
            cell.profilePic.clipsToBounds = true
            cell.toFollowBut.tag = indexPath.row
            
            userDefault.setObject(user_id, forKey: "storedUserIds")
            
            
            return cell
    }
    func reloadDiscover() {
        
        self.discoverTable.reloadData()
        print("pressed")
    }

    
}
