//
//  adoptionsViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 31/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import Social

class adoptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, adoptCellDelegator {
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var a1: UIBarButtonItem!
    
    @IBOutlet weak var a2: UIBarButtonItem!
    
    var customView = UIView()
    var selectedView = UIView()
    
    @IBOutlet weak var navigBar: UINavigationBar!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var adoptionsTable: UITableView!
    
    @IBOutlet weak var giveForAdoptions: UITableView!
    
    var username = [String]()
    var pet_info = [String]()
    var message = [String]()
    var post_user_id = [String]()
    
    var UserId = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height + self.navigBar.bounds.size.height, self.view.bounds.size.width / 2, 3))
        customView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(customView)
        
        selectedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 2,self.toolBar.frame.size.height + self.navigBar.bounds.size.height, self.view.bounds.size.width / 2, 3))
        selectedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(selectedView)
        
        selectedView.hidden = true
        
        giveForAdoptions.hidden = true

        adoptions()
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    func adoptions() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/adopt/show")!)
        request.HTTPMethod = "GET"
        view.showLoading()
        
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
            //print(responseString)
            
            let json = JSON(data: data!)
            //print(json["notifications"].arrayValue)
            for item in json["adoptions"].arrayValue {
                
            var str = item["pet_type"].stringValue.capitalizedString
            var str1 = item["breed"].stringValue.capitalizedString
            var str2 = item["age"].stringValue
            
            self.pet_info.append(str + "," + str1 + "- " + str2 + " years old")
            self.message.append(item["description"].stringValue)
            self.username.append(item["user"]["username"].stringValue.capitalizedString)
            self.post_user_id.append(item["user"]["id"].stringValue)
                
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.adoptionsTable.reloadData()
                    self.view.hideLoading()
                })
                
            }
            //print(self.username_m)
            //print(self.post_user_id)
        }
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    @IBAction func adopt1(sender: AnyObject) {
        
        selectedView.hidden = true
        customView.hidden = false
        a1.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        a2.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        a2.tag = 0
        a1.tag = 1
        //notifTable.reloadData()
        //messageTable.hidden = true
        //notifTable.hidden = false
        
        
        adoptionsTable.hidden = false
        
    }
    
    @IBAction func adopt2(sender: AnyObject) {
        
        customView.hidden = true
        selectedView.hidden = false
        a2.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        a1.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        a1.tag = 0
        a2.tag = 1
        //notifTable.reloadData()
        //notifTable.hidden = true
        //messageTable.hidden = false
        
        adoptionsTable.hidden = true
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("adopt", forIndexPath: indexPath) as! adopt_cell
        //cell.textLabel?.text = "test"
        
        cell.delegate = self
        
        
        cell.username.text = username[indexPath.row]
        cell.pet_info.text = pet_info[indexPath.row]
        cell.profilePic.image = UIImage(named: "dawg.png")
        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
        cell.profilePic.clipsToBounds = true
        
        cell.postedImage.image = UIImage(named: "no_image.jpg")
        
        cell.shareBut.tag = indexPath.row
        cell.usernamePress.tag = indexPath.row
        
        return cell
    }
    
    func share(cell_id: Int) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
            
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                print("Cancel")
        }
        
        actionSheetControllerIOS8.addAction(cancelActionButton)
            
        let shareFBActionButton: UIAlertAction = UIAlertAction(title: "Share to Facebook", style: .Default)
            { action -> Void in
                print("FB shared")
                
                //////////////
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                    var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    
                    fbShare.setInitialText("Adopt this pet on PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.adoptionsTable.cellForRowAtIndexPath(indexPath) as! adopt_cell
                    
                    fbShare.addImage(cell.postedImage.image)
                    self.presentViewController(fbShare, animated: true, completion: nil)
                    
                } else {
                    var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                /////////////
            }
            actionSheetControllerIOS8.addAction(shareFBActionButton)
            
            let TweetActionButton: UIAlertAction = UIAlertAction(title: "Share to Twitter", style: .Default)
            { action -> Void in
                print("Tweet")
                ////////////
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                    
                    var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    tweetShare.setInitialText("Adopt this pet on PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.adoptionsTable.cellForRowAtIndexPath(indexPath) as! adopt_cell
                    
                    tweetShare.addImage(cell.postedImage.image)
                    
                    self.presentViewController(tweetShare, animated: true, completion: nil)
                    
                } else {
                    
                    var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                ////////////
            }
            actionSheetControllerIOS8.addAction(TweetActionButton)
            
            self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
            
        

        
        
    }
    
    func showProf(showTag: Int) {
        
        UserId = post_user_id[showTag]
        
        self.performSegueWithIdentifier("adoptToShowProfile", sender: self)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "adoptToShowProfile") {
            
            let profVC = segue.destinationViewController as! showProfileViewController
            
            profVC.uid = UserId
        }
        
    }

    
    

}
