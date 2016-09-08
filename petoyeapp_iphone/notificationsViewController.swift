//
//  notificationsViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 04/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

var his_id = String()
var his_name = String()
var index = Int()
var didSelect = false


class notificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, notifDelegate, notif2Delegate
{

    @IBOutlet weak var tool: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var messages: UIBarButtonItem!
    @IBOutlet weak var notifications: UIBarButtonItem!
    
    
    var customView = UIView()
    var selectedView = UIView()
    var username = [String]()
    var notif = [String]()
    var u_id = [String]()
    var p_id = [String]()
    var profileUrl = [String]()
    var postpic = [String]()
    
    var uid = String()
    var pid = String()
    
    var username_m = [String]()
    var hisId = [String]()
    
    var refreshControl: UIRefreshControl!

    @IBOutlet weak var notifTable: UITableView!
    @IBOutlet weak var messageTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //toolBar.frame.size.height = 64
        
        refreshControl = UIRefreshControl()

        notifTable.addSubview(refreshControl)
        
        //messageTable.addSubview(refreshControl)
        
        notifTable.tableFooterView = UIView(frame: CGRectZero)
        messageTable.tableFooterView = UIView(frame: CGRectZero)
        
        customView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height + 20, self.view.bounds.size.width / 2, 3))
        customView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(customView)
        
        selectedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 2,self.toolBar.frame.size.height + 20, self.view.bounds.size.width / 2, 3))
        selectedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(selectedView)
        
        selectedView.hidden = true
        
        messageTable.hidden = true

        // Do any additional setup after loading the view.
        
        //var swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        //swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        //self.view.addGestureRecognizer(swipeUp)
        
        //var swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        //swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        //self.view.addGestureRecognizer(swipeDown)
        
        notifs()
        //conversations()
    }
    
    func refresh()
    {
        // Updating your data here...
        
        //self.tableView.reloadData()
        
        
        self.refreshControl?.endRefreshing()
    }
    
    
    func notifs() {
        //print("called")
        
        var data = 6
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(data)/notifications")!)
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
            for item in (json["notify"].arrayValue) {
                //print("new")
                //print(item.stringValue)
                var str = item.stringValue
                
                var initial = str.componentsSeparatedByString("[")
                var uname = initial[0].capitalizedString
                self.username.append(uname)
                
                var next = initial[1].componentsSeparatedByString("]")
                var uid = next[0]
                self.u_id.append(uid)
                
                
                if initial.count == 3{
                    
                    var third = initial[2].componentsSeparatedByString("]")
                    var profurl = third[0]
                    self.profileUrl.append(profurl)
                    
                    var clear = third[1].removeAtIndex(third[1].startIndex)
                    var not = third[1]
                    self.notif.append(not)
                    
                }
                else if initial.count == 5{
                    
                    
                    
                    var third = initial[2].componentsSeparatedByString("]")
                    var profurl = third[0]
                    self.profileUrl.append(profurl)
                    
                    var clear = third[1].removeAtIndex(third[1].startIndex)
                    var not = third[1]
                    self.notif.append(not)
                    
                    var fourth = initial[3].componentsSeparatedByString("]")
                    var postid = fourth[0]
                    self.p_id.append(postid)
                    
                    var fifth = initial[4].componentsSeparatedByString("]")
                    var postpic = fifth[0]
                    self.postpic.append(postpic)
                    
                }

                
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.notifTable.reloadData()
                    self.view.hideLoading()
                    //self.navigationController!.tabBarItem.badgeValue = String(self.notif.count)
                    //self.tabBarController?.tabBarItem.badgeValue = String(self.notif.count)
                    self.tabBarController?.selectedViewController?.tabBarItem.badgeValue = String(self.notif.count);
                })

            }
            print(self.username)
            print(self.u_id)
            print(self.profileUrl)
            print(self.notif)
            print(self.p_id)
            print(self.postpic)
            
        }
        task.resume()
        
    }
    
    func conversations() {
        
        var data = 1
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/conversations/\(data)/all")!)
        request.HTTPMethod = "GET"
        view.showLoading()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            let json = JSON(data: data!)
            //print(json["notifications"].arrayValue)
            for item in json["conversations"].arrayValue {
                self.username_m.append(item["username"].stringValue.capitalizedString)
                self.hisId.append(item["id"].stringValue)
                self.profileUrl.append(item["imageurl"].stringValue)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.messageTable.reloadData()
                    self.view.hideLoading()
                })

            }
            //print(self.username_m)
        }
        task.resume()

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func message(sender: AnyObject) {
        
        customView.hidden = true
        selectedView.hidden = false
        messages.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        notifications.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        notifications.tag = 0
        messages.tag = 1
        //notifTable.reloadData()
        notifTable.hidden = true
        messageTable.hidden = false
        
        if username_m.count == 0 {
            conversations()
        }
        
    }
    
    @IBAction func notifications(sender: AnyObject) {
        
        selectedView.hidden = true
        customView.hidden = false
        notifications.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        messages.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        messages.tag = 0
        notifications.tag = 1
        //notifTable.reloadData()
        messageTable.hidden = true
        notifTable.hidden = false
        
    }

    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var items = Int()
        if(tableView == self.notifTable) {
            items = username.count
        }
        else {
            items = username_m.count
        }
        return items
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.messageTable{
            
            //print(indexPath.row)
            his_id = hisId[indexPath.row]
            his_name = username_m[indexPath.row]
            
            //print(his_id)
            //print(his_name)
            
            self.performSegueWithIdentifier("message_show", sender: self)
            
            index = indexPath.row
            
            didSelect = true
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        print(his_id)
        print(his_name)
        
        if (segue.identifier == "message_show") {
            
            //let navVC = segue.destinationViewController as! UINavigationController
            
            //var messageController = navVC.viewControllers.first as! messagesViewController;
            let messageController = segue.destinationViewController as! messagesViewController
            
            messageController.hisId = his_id
            messageController.hisName = his_name
        }
        else if (segue.identifier == "notifToShowProfile") {
            
            let profVC = segue.destinationViewController as! showProfileViewController
            
            profVC.uid = uid
        }
        else if (segue.identifier == "notifToPost") {
            
            let postVC = segue.destinationViewController as! showPostViewController
            
            postVC.pid = pid

        }
        
    }
    
    /*
    override func viewDidAppear(animated: Bool) {
        
        if didSelect == true {
            
            print(index)
            
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            let cell = self.messageTable.cellForRowAtIndexPath(indexPath) as! conversation_cell
            
            cell.last_message.hidden = false
            
            cell.last_message.text = NSUserDefaults.standardUserDefaults().stringForKey("last")!
            
        }
        
    }
 */
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            var cell = UITableViewCell()
            
            if(tableView==self.notifTable)
            {
                
                    if p_id[indexPath.row].isEmpty {
                        
                    //cell for followed you
                    let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! notification_cell
                        
                        cell.delegate = self
                        
                        if profileUrl[indexPath.row].isEmpty {
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.profilePic.image = UIImage(named: "no_image.jpg")
                                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                cell.profilePic.clipsToBounds = true
                            })
                            
                            
                            
                        }
                        else
                        {
                            
                            let url = NSURL(string: profileUrl[indexPath.row])
                            
                            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                                
                                if error != nil
                                {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        cell.profilePic.image = UIImage(named: "no_image.jpg")
                                        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                        cell.profilePic.clipsToBounds = true
                                    })
                                }
                                else
                                {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        if let image = UIImage(data: data!) {
                                            
                                            cell.profilePic.image = image
                                            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                            cell.profilePic.clipsToBounds = true
                                        }
                                        
                                    })
                                    
                                }
                                
                                
                            }
                            task.resume()
                            
                            
                            
                        }

                        
                        cell.username.text = username[indexPath.row]
                        cell.followNotif.text =
                        notif[indexPath.row]
                        
                        
                        cell.usernamePress.tag = indexPath.row
                        return cell
 
                    }
                    else {
                        
                        //cell for commented/liked
                        let cell = tableView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath) as! notification2_cell
                        
                        cell.delegate = self
                        
                        
                        if profileUrl[indexPath.row].isEmpty {
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.profilePic.image = UIImage(named: "no_image.jpg")
                                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                cell.profilePic.clipsToBounds = true
                            })
                            
                            
                            
                        }
                        else
                        {
                            
                            let url = NSURL(string: profileUrl[indexPath.row])
                            
                            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                                
                                if error != nil
                                {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        cell.profilePic.image = UIImage(named: "no_image.jpg")
                                        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                        cell.profilePic.clipsToBounds = true
                                    })
                                }
                                else
                                {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        if let image = UIImage(data: data!) {
                                            
                                            cell.profilePic.image = image
                                            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                            cell.profilePic.clipsToBounds = true
                                        }
                                        
                                    })
                                    
                                }
                                
                                
                            }
                            task.resume()
                            
                            
                            
                        }

                        
                        
                        if postpic[indexPath.row].isEmpty {
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.postImage.image = UIImage(named: "no_image.jpg")
                            })
                            
                            
                            
                        }
                        else
                        {
                            
                            let url = NSURL(string: postpic[indexPath.row])
                            
                            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                                
                                if error != nil
                                {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        cell.postImage.image = UIImage(named: "no_image.jpg")
                                    })
                                }
                                else
                                {
                                    dispatch_async(dispatch_get_main_queue(), {
                                        
                                        if let image = UIImage(data: data!) {
                                            
                                            cell.postImage.image = image
                                        }
                                        
                                    })
                                    
                                }
                                
                                
                            }
                            task.resume()
                           
                        }
                      
                        cell.username.text = username[indexPath.row]
                        cell.c_l_notif.text = notif[indexPath.row]
                        cell.profilePic.image = UIImage(named: "dawg.png")
                        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                        cell.profilePic.clipsToBounds = true
                        cell.postImage.image = UIImage(named: "dawg1.png")
                        
                        
                        //cell.postImage.layer.cornerRadius = cell.postImage.frame.size.width/2
                        //cell.postImage.clipsToBounds = true
                        
                        
                        cell.usernamePress.tag = indexPath.row
                        cell.postImagePress.tag = indexPath.row
                        return cell
 
                    }
 
                
                
            }
            else
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! conversation_cell
                
                //cell.textLabel?.text = "hola"
                
                if profileUrl[indexPath.row].isEmpty {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.profilePic.image = UIImage(named: "no_image.jpg")
                        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                        cell.profilePic.clipsToBounds = true
                    })
                    
                    
                    
                }
                else
                {
                    
                    let url = NSURL(string: profileUrl[indexPath.row])
                    
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                        
                        if error != nil
                        {
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.profilePic.image = UIImage(named: "no_image.jpg")
                                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                cell.profilePic.clipsToBounds = true
                            })
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                if let image = UIImage(data: data!) {
                                    
                                    cell.profilePic.image = image
                                    cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                                    cell.profilePic.clipsToBounds = true
                                }
                                
                            })
                            
                        }
                        
                        
                    }
                    task.resume()
                    
                    
                    
                }
 
                cell.username.text = username_m[indexPath.row]
                
                cell.last_message.hidden = true
                
                return cell
                
            }

            
    }
    
    func showProf(showTag: Int) {
        
        
    uid = u_id[showTag]

    self.performSegueWithIdentifier("notifToShowProfile", sender: self)
        
    }
    
    func show(showTag: Int) {
        
    uid = u_id[showTag]
        
    self.performSegueWithIdentifier("notifToShowProfile", sender: self)
        
    }
    
    func postShow(showTag: Int) {
        
        pid = p_id[showTag]
        
        self.performSegueWithIdentifier("notifToPost", sender: self)
        
    }
    




}
