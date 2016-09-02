//
//  TableViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import Social
import XLActionController

var userDefault = NSUserDefaults.standardUserDefaults()

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyCustomCellDelegator, UIActionSheetDelegate, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    @IBOutlet weak var feedTable: UITableView!
    @IBOutlet weak var followedTable: UITableView!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var trendingTable: UITableView!
    
    @IBOutlet weak var Open: UIBarButtonItem!
    @IBOutlet weak var post: UIBarButtonItem!
    
    var post_user_id = [String]()
    var username = [String]()
    var message = [String]()
    var like_count = [String]()
    var comment_count = [String]()
    var post_id = [String]()
    var created_at = [String]()
    var imageurl = [String]()
    var timestamp = [String]()
    
    var post_user_id1 = [String]()
    var username1 = [String]()
    var message1 = [String]()
    var like_count1 = [String]()
    var comment_count1 = [String]()
    var post_id1 = [String]()
    var created_at1 = [String]()
    var imageurl1 = [String]()
    var timestamp1 = [String]()
    
    var post_user_id2 = [String]()
    var username2 = [String]()
    var message2 = [String]()
    var like_count2 = [String]()
    var comment_count2 = [String]()
    var post_id2 = [String]()
    var created_at2 = [String]()
    var imageurl2 = [String]()
    var timestamp2 = [String]()
    
    
    
    var s_username = [String]()
    var s_userid = [String]()
    var s_ownertype = [String]()
    var s_breed = [String]()
    var s_location = [String]()
    var s_profilepic = [String]()


    var PostId = String()
    var UserId = String()


    
    var trendingView = UIView()
    var followedView = UIView()
    var nearbyView = UIView()
    //var searchController: UISearchController!
    var CustomSearchController: customSearchController!

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var trending: UIBarButtonItem!
    @IBOutlet weak var followed: UIBarButtonItem!
    @IBOutlet weak var nearby: UIBarButtonItem!
    
    var activityIndicatorImage = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        
        
        
        //followedTable.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0)
        //feedTable.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0)
        
        
        navigationController?.navigationBar.hidden = true

        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        //indicator thing
        trendingView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height + self.navBar.bounds.size.height, self.view.bounds.size.width / 3, 3))
        trendingView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(trendingView)
        followedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 3, self.toolBar.frame.size.height + self.navBar.bounds.size.height, self.view.bounds.size.width / 3, 3))
        followedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(followedView)
        followedView.hidden = true
        nearbyView = UIView(frame: CGRectMake(self.view.bounds.size.width * 0.66, self.toolBar.frame.size.height + self.navBar.bounds.size.height, self.view.bounds.size.width / 3, 3))
        nearbyView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(nearbyView)
        nearbyView.hidden = true

        //Get request for geting feeds
        //getNearby()
        //get request for getting followed feeds
        //getFollowed()
        
        feedTable.hidden = true
        followedTable.hidden = true
        searchTable.hidden = true
        
        searchTable.tableFooterView = UIView(frame: CGRectZero)
        
        //self.edgesForExtendedLayout = .None
        //self.extendedLayoutIncludesOpaqueBars = false
        //self.automaticallyAdjustsScrollViewInsets = false
        
        if username2.count == 0 {
            
            getTrending()
        }
        
    }
    
    
    func followedTableScrollToBottom(animated: Bool) {
        
        let delay = 0.000005 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.followedTable.numberOfSections
            let numberOfRows = self.followedTable.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.followedTable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    func feedTableScrollToBottom(animated: Bool) {
        
        let delay = 0.000005 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.feedTable.numberOfSections
            let numberOfRows = self.feedTable.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.feedTable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    func trendingTableScrollToBottom(animated: Bool) {
        
        let delay = 0.000005 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.trendingTable.numberOfSections
            let numberOfRows = self.trendingTable.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.trendingTable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }



    
    
    func getNearby() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/2/nearbyfeeds")!)
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
            
            for item in json["feeds"].arrayValue {
                for innerItem in item["feeds"].arrayValue {
                    self.username.append(item["username"].stringValue.capitalizedString)
                    self.post_id.append(innerItem["id"].stringValue)
                    self.message.append(innerItem["message"].stringValue)
                    self.like_count.append(innerItem["like_count"].stringValue)
                    self.comment_count.append(innerItem["comment_count"].stringValue)
                    self.created_at.append(innerItem["created_at"].stringValue)
                    
                    var converted = self.convert(innerItem["created_at"].stringValue)
                    
                    self.timestamp.append(converted)
                    
                    
                    //print(date)
                    
                    
                    self.imageurl.append(innerItem["imageurl"].stringValue)
                    ///////
                    
                    self.post_user_id.append(item["id"].stringValue)
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.feedTable.reloadData()
                        self.feedTableScrollToBottom(false)
                        self.view.hideLoading()
                    })
                }
            }
            //print(self.username)
            //print(self.message)
            //print(self.like_count)
            //print(self.comment_count)
            //print(self.post_user_id)
            //print(self.post_id)
            //print(self.created_at)
            //print(self.imageurl)
            //print(self.timestamp)
            
            
            //for now doing nearby feeds
        }
        task.resume()
    }
    
    

    
    
    func getTrending()
    {
        
        //change url to trending
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/1/followedfeeds")!)
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
            
            for item in json["feeds"].arrayValue {
                self.username2.append(item["user"]["username"].stringValue.capitalizedString)
                self.post_user_id2.append(item["user"]["id"].stringValue)
                self.post_id2.append(item["id"].stringValue)
                self.message2.append(item["message"].stringValue)
                self.like_count2.append(item["like_count"].stringValue)
                self.comment_count2.append(item["comment_count"].stringValue)
                self.created_at2.append(item["created_at"].stringValue)
                var converted = self.convert(item["created_at"].stringValue)
                //print(converted)
                
                self.timestamp2.append(converted)
                
                self.imageurl2.append(item["imageurl"].stringValue)
                /////////
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.trendingTable.reloadData()
                    self.trendingTableScrollToBottom(false)
                    self.view.hideLoading()
                })
                
            }
            
            //print(self.username2)
            //print(self.timestamp2)
            
            //for now doing followed feeds
        }
        task.resume()

    }
    
    func getFollowed()
    {
     
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/1/followedfeeds")!)
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
            
            for item in json["feeds"].arrayValue {
                self.username1.append(item["user"]["username"].stringValue.capitalizedString)
                self.post_user_id1.append(item["user"]["id"].stringValue)
                self.post_id1.append(item["id"].stringValue)
                self.message1.append(item["message"].stringValue)
                self.like_count1.append(item["like_count"].stringValue)
                self.comment_count1.append(item["comment_count"].stringValue)
                self.created_at1.append(item["created_at"].stringValue)
                var converted = self.convert(item["created_at"].stringValue)
                //print(converted)
                
                self.timestamp1.append(converted)

                
                self.imageurl1.append(item["imageurl"].stringValue)
                /////////
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.followedTable.reloadData()
                        self.followedTableScrollToBottom(false)
                        self.view.hideLoading()
                    })
                
            }
            //print(self.username1)
            //print(self.message1)
            //print(self.like_count1)
            //print(self.comment_count1)
            //print(self.post_user_id1)
            //print(self.post_id1)
            //print(self.created_at1)
            //print(self.imageurl1)

            //print(self.timestamp1)
            
            
            //for now doing followed feeds
        }
        task.resume()

        
    }
    
    
    
    @IBAction func trending(sender: AnyObject) {
        trendingView.hidden = false
        followedView.hidden = true
        nearbyView.hidden = true
        
        trending.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        followed.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        nearby.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        trending.tag = 1
        followed.tag = 0
        nearby.tag = 0
        
        //notifTable.reloadData()
        //notifTable.hidden = true
        //messageTable.hidden = false
        
        feedTable.hidden = true
        followedTable.hidden = true
        trendingTable.hidden = false
        
        
    }
    
    @IBAction func followed(sender: AnyObject) {
        trendingView.hidden = true
        followedView.hidden = false
        nearbyView.hidden = true
        
        followed.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        trending.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        nearby.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        trending.tag = 0
        followed.tag = 1
        nearby.tag = 0
        
        feedTable.hidden = true
        followedTable.hidden = false
        trendingTable.hidden = true
        
        
        if username1.count == 0 {
            
            getFollowed()
        }
        
    }
    
    @IBAction func nearby(sender: AnyObject) {
        trendingView.hidden = true
        followedView.hidden = true
        nearbyView.hidden = false

        nearby.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        trending.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        followed.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        trending.tag = 0
        followed.tag = 0
        nearby.tag = 1
        
        feedTable.hidden = false
        followedTable.hidden = true
        trendingTable.hidden = true
        
        if username.count == 0 {
            
            getNearby()
        }
    }
    
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var items = Int()
        if(tableView == self.followedTable) {
            items = username1.count
        }
        else if (tableView == self.feedTable) {
            items = username.count
        }
        else if (tableView == self.searchTable) {
            items = s_username.count
        }
        else if (tableView == self.trendingTable) {
            items = username2.count
            // trending is followed for now
        }
        return items
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            
            var cell = UITableViewCell()

            if (tableView == self.followedTable)
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("feed1", forIndexPath: indexPath) as! feed
                //cell.textLabel?.text = "TEST"
                cell.delegate = self
                
                if imageurl1[indexPath.row].isEmpty {
                 
                    cell.postedImage.image = UIImage(named: "no_image.jpg")
                    

                }
                else
                {
                  
                    let url = NSURL(string: imageurl1[indexPath.row])
                    
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                        
                        if error != nil
                        {
                            cell.postedImage.image = UIImage(named: "no_image.jpg")
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                if let image = UIImage(data: data!) {
                                    
                                    cell.postedImage.image = image
                                }
                                
                            })
                            
                        }
                        
                        
                    }
                    task.resume()

                    
                    
                }
                
                cell.username.text = username1[indexPath.row]
                
                cell.message.text = message1[indexPath.row]
                cell.likecount.text = like_count1[indexPath.row]
                cell.commentcount.text = comment_count1[indexPath.row]
                cell.timestamp.text = timestamp1[indexPath.row]
               
                
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row
                cell.reportPress.tag = indexPath.row
                cell.likedBy.tag = indexPath.row
                cell.share.tag = indexPath.row
                
                cell.profilePic.image = UIImage(named: "amey.jpg")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                

                return cell
            }
            else if(tableView == self.feedTable){
                
                let cell = tableView.dequeueReusableCellWithIdentifier("feed", forIndexPath: indexPath) as! feed
                //cell.textLabel?.text = "TEST"
                cell.delegate = self
                
                if imageurl[indexPath.row].isEmpty {
                    
                    cell.postedImage.image = UIImage(named: "no_image.jpg")
                    
                    
                    
                }
                else
                {
                    
                    let url = NSURL(string: imageurl[indexPath.row])
                    
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                        
                        if error != nil
                        {
                            cell.postedImage.image = UIImage(named: "no_image.jpg")
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                if let image = UIImage(data: data!) {
                                    
                                    cell.postedImage.image = image
                                }
                                
                            })
                            
                        }
                        
                        
                    }
                    task.resume()
                    
                    
                    
                }

                
                cell.profilePic.image = UIImage(named: "amey.jpg")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                
                cell.username.text = username[indexPath.row]
                

                
                cell.message.text = message[indexPath.row]
                cell.likecount.text = like_count[indexPath.row]
                cell.commentcount.text = comment_count[indexPath.row]
                cell.timestamp.text = timestamp[indexPath.row]
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row
                cell.reportPress.tag = indexPath.row
                cell.likedBy.tag = indexPath.row
                cell.share.tag = indexPath.row
                
                //cell.like_selected.hidden = true
                
                return cell

                
            }
            
            else if (tableView == self.searchTable){
                let cell = tableView.dequeueReusableCellWithIdentifier("search", forIndexPath: indexPath) as! search_cell
                //cell.textLabel?.text = "TEST"
                
                cell.username.text = s_username[indexPath.row]
                cell.owner_type.text = s_ownertype[indexPath.row]
                cell.breed.text = s_breed[indexPath.row]
                cell.location.text = "Dadar, Mumbai"
                cell.profilePic.image = UIImage(named: "dawg.png")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                
                
                return cell
            }
            
            else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("trending", forIndexPath: indexPath) as! feed
                //cell.textLabel?.text = "test"
                
                cell.delegate = self
                
                if imageurl2[indexPath.row].isEmpty {
                    
                    cell.postedImage.image = UIImage(named: "no_image.jpg")
                    
                    
                }
                else
                {
                    
                    let url = NSURL(string: imageurl2[indexPath.row])
                    
                    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                        
                        if error != nil
                        {
                            cell.postedImage.image = UIImage(named: "no_image.jpg")
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                if let image = UIImage(data: data!) {
                                    
                                    cell.postedImage.image = image
                                }
                                
                            })
                            
                        }
                        
                        
                    }
                    task.resume()
                    
                    
                    
                }
                
                cell.username.text = username2[indexPath.row]
                
                cell.message.text = message2[indexPath.row]
                cell.likecount.text = like_count2[indexPath.row]
                cell.commentcount.text = comment_count2[indexPath.row]
                cell.timestamp.text = timestamp2[indexPath.row]
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row
                cell.reportPress.tag = indexPath.row
                cell.likedBy.tag = indexPath.row
                cell.share.tag = indexPath.row
                
                cell.profilePic.image = UIImage(named: "amey.jpg")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                
                
                return cell
            }
            
            
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.searchTable {
            
            //UserId = post_user_id1[userTag]
            
            UserId = s_userid[indexPath.row]
            
            self.performSegueWithIdentifier("homeToShowProfile", sender: self)
        }
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    func likeIt(likeTag: Int) {
        
        //print(likeTag)
        
        if followed.tag == 1 {
            
            var likedPostId = post_id1[likeTag]
            
            
            let indexPath = NSIndexPath(forRow: likeTag, inSection: 0)
            let cell = self.followedTable.cellForRowAtIndexPath(indexPath) as! feed
            view.showLoading()
            
            cell.likePress.viewWithTag(likeTag)?.hidden = true
            
            
            //liking a post API call
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(likedPostId)/like")!)
            request.HTTPMethod = "POST"
            let postString = "uid=47"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    //print(error!)
                    return
                }
                
                if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
                {
                    //set like buttonimage to filled
                    var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                    print(responseString)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.followedTable.reloadData()
                        self.view.hideLoading()
                    })
                    
                    
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    
                    let json = JSON(data: data!)
                    let bug = json["errors"].stringValue
                    // pop up showing already liked and set image to filled
                    self.view.hideLoading()
                    
                    if bug == "already liked"
                    {
                        // pop up showing already liked and set image to filled
                        print("already liked")
                        //self.view.hideLoading()
                        
                        //self.likePress.viewWithTag(self.likePress.tag)?.hidden = true
                    }
                    else {
                        print("try again later")
                        //self.view.hideLoading()
                    }
                }
                
            }
            task.resume()

        }
        else if nearby.tag == 1 {

            var likedPostId = post_id[likeTag]
            
            
            let indexPath = NSIndexPath(forRow: likeTag, inSection: 0)
            let cell = self.feedTable.cellForRowAtIndexPath(indexPath) as! feed
            
            view.showLoading()
            
            cell.likePress.viewWithTag(likeTag)?.hidden = true
            
            
            //liking a post API call
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(likedPostId)/like")!)
            request.HTTPMethod = "POST"
            let postString = "uid=47"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    //print(error!)
                    return
                }
                
                if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
                {
                    //set like buttonimage to filled
                    var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                    print(responseString)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.feedTable.reloadData()
                        self.view.hideLoading()
                    })
                    
                    
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    
                    let json = JSON(data: data!)
                    let bug = json["errors"].stringValue
                    // pop up showing already liked and set image to filled
                    
                    self.view.hideLoading()
                    if bug == "already liked"
                    {
                        // pop up showing already liked and set image to filled
                        print("already liked")
                        //self.view.hideLoading()
                        
                        //self.likePress.viewWithTag(self.likePress.tag)?.hidden = true
                    }
                    else {
                        print("try again later")
                        //self.view.hideLoading()
                    }
                }
                
            }
            task.resume()
            
        }
        else if trending.tag == 1 {
            
            var likedPostId = post_id2[likeTag]
            
            
            let indexPath = NSIndexPath(forRow: likeTag, inSection: 0)
            let cell = self.trendingTable.cellForRowAtIndexPath(indexPath) as! feed
            //view.showLoading()
            
            cell.likePress.viewWithTag(likeTag)?.hidden = true
            
            
            //liking a post API call
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(likedPostId)/like")!)
            request.HTTPMethod = "POST"
            let postString = "uid=48"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    //print(error!)
                    return
                }
                
                if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
                {
                    //set like buttonimage to filled
                    var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                    print(responseString)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.followedTable.reloadData()
                        //self.view.hideLoading()
                    })
                    
                    
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    
                    let json = JSON(data: data!)
                    let bug = json["errors"].stringValue
                    // pop up showing already liked and set image to filled
                    //self.view.hideLoading()
                    
                    if bug == "already liked"
                    {
                        // pop up showing already liked and set image to filled
                        print("already liked")
                        //self.view.hideLoading()
                        
                        //self.likePress.viewWithTag(self.likePress.tag)?.hidden = true
                    }
                    else {
                        print("try again later")
                        //self.view.hideLoading()
                    }
                }
                
            }
            task.resume()
            

        }
        
        
    }
    
    func showProfile(userTag: Int) {

        if followed.tag == 1 {
            UserId = post_user_id1[userTag]
            
            self.performSegueWithIdentifier("homeToShowProfile", sender: self)
        }
        else if nearby.tag == 1 {
            UserId = post_user_id[userTag]
            
            self.performSegueWithIdentifier("homeToShowProfile", sender: self)
        }
        else if trending.tag == 1 {
            UserId = post_user_id2[userTag]
            
            self.performSegueWithIdentifier("homeToShowProfile", sender: self)
        }
    }

    func commentIt(commentTag: Int) {
        
        //print(commentTag)
        
        if followed.tag == 1 {
            
            PostId = post_id1[commentTag]
            
            self.performSegueWithIdentifier("trendingCommentShower", sender: self)
            
        }
        else if nearby.tag == 1 {
            
            PostId = post_id[commentTag]
            
            self.performSegueWithIdentifier("trendingCommentShower", sender: self)
        }
        else if trending.tag == 1 {
            
            PostId = post_id2[commentTag]
            
            self.performSegueWithIdentifier("trendingCommentShower", sender: self)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "trendingCommentShower") {
            
            let commentVC = segue.destinationViewController as! CommentsViewController
            
            commentVC.pid = PostId
            
        }
        else if (segue.identifier == "feedToLikedBy") {
            
            let likeVC = segue.destinationViewController as! LikesViewController
            
            likeVC.pid = PostId
            
        }
        else if (segue.identifier == "homeToShowProfile") {
            
            let profVC = segue.destinationViewController as! showProfileViewController
            
            profVC.uid = UserId
        }
        
    }
    
    func likedBy(byTag: Int) {
        
        
        if followed.tag == 1 {
            
            PostId = post_id1[byTag]
            
            self.performSegueWithIdentifier("feedToLikedBy", sender: self)
            
        }
        else if nearby.tag == 1 {
            
            PostId = post_id[byTag]
            
            self.performSegueWithIdentifier("feedToLikedBy", sender: self)
            
        }
        else if trending.tag == 1 {
            
            PostId = post_id2[byTag]
            
            self.performSegueWithIdentifier("feedToLikedBy", sender: self)
        }
        
    }
    
    func shareIt(shareTag: Int) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        if followed.tag == 1 {
            
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
                    
                    fbShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                    let cell = self.followedTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
                    tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                    let cell = self.followedTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
        
        else if nearby.tag == 1 {
            
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
                    
                    fbShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                    let cell = self.feedTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
                    tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                    let cell = self.feedTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
        
        else if trending.tag == 1 {
            
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
                    
                    fbShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                    let cell = self.trendingTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
                    tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                    let cell = self.trendingTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
        
        
    }
    
    
    func report(cell_id:Int) {

        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        if (followed.tag == 1) {
            
            
            
            
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
                    
                    fbShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.followedTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
                    tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.followedTable.cellForRowAtIndexPath(indexPath) as! feed
                    
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
            
            let ReportActionButton: UIAlertAction = UIAlertAction(title: "Report", style: .Destructive)
            { action -> Void in
                print("Report")
                
                self.PostId = self.post_id1[cell_id]
                
                print(self.PostId)
                
                ///////////////////////////
                
                
                
                let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(self.PostId)/report")!)
                request.HTTPMethod = "POST"
                let postString = "report=1"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                    guard error == nil && data != nil else {                                                          // check for fundamental networking error
                        print(error!)
                        return
                    }
                    
                    if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print(response!)
                        
                    }
                    
                    var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                    print(responseString)
                    
                    
                    
                }
                task.resume()

                //////////////////////////////
                
                
            }
            actionSheetControllerIOS8.addAction(ReportActionButton)
            
            self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
            
        }
        
        else if nearby.tag == 1 {
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let followActionButton: UIAlertAction = UIAlertAction(title: "Follow", style: .Default)
        { action -> Void in
            print("Follow")
            
            
            var hisid = self.post_user_id[cell_id]
            
            var my_id = 1
            
            ////////////////////////////
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/\(my_id)/follow")!)
            request.HTTPMethod = "POST"
            let postString = "hisid=\(hisid)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error!)
                    return
                }
                
                if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
                {
                    // pop up followed
                }
                
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                    //print("statusCode should be 201, but is \(httpStatus.statusCode)")
                    //print(response!)
                    
                    let json = JSON(data: data!)
                    let bug = json["errors"].stringValue
                    
                    if bug == "already following"
                    {
                        // pop up showing be the first to comment
                        print("already following")
                        
                    }
                    else {
                        print("try again later")
                    }

                    
                    
                }
                
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(responseString!)
                
                
            }
            task.resume()
            
            
            /////////////////////////////
            
        }
        actionSheetControllerIOS8.addAction(followActionButton)
        
        let shareFBActionButton: UIAlertAction = UIAlertAction(title: "Share to Facebook", style: .Default)
        { action -> Void in
            print("FB shared")
            /////////////
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                fbShare.setInitialText("Look at this super cute pet via PetOye!")
                let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                let cell = self.feedTable.cellForRowAtIndexPath(indexPath) as! feed
                
                fbShare.addImage(cell.postedImage.image)
                
                self.presentViewController(fbShare, animated: true, completion: nil)
                
            } else {
                var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            ////////////
        }
        actionSheetControllerIOS8.addAction(shareFBActionButton)
        
        let TweetActionButton: UIAlertAction = UIAlertAction(title: "Share to Twitter", style: .Default)
        { action -> Void in
            print("Tweet")
            
            ////////////
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                
                var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                let cell = self.feedTable.cellForRowAtIndexPath(indexPath) as! feed
                
                tweetShare.addImage(cell.postedImage.image)
                
                self.presentViewController(tweetShare, animated: true, completion: nil)
                
            } else {
                
                var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            ///////////
        }
        actionSheetControllerIOS8.addAction(TweetActionButton)
        
        let ReportActionButton: UIAlertAction = UIAlertAction(title: "Report", style: .Destructive)
        { action -> Void in
            print("Report")
            
            self.PostId = self.post_id[cell_id]
            
            /////////////////////////
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(self.PostId)/report")!)
            request.HTTPMethod = "POST"
            let postString = "report=1"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error!)
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print(response!)
                    
                }
                
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(responseString)
                
            }
            task.resume()
            
            ////////////////////////////////
            
            
            
            
        }
        actionSheetControllerIOS8.addAction(ReportActionButton)
        
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
        }

        else if trending.tag == 1 {
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)
            
            let followActionButton: UIAlertAction = UIAlertAction(title: "Follow", style: .Default)
            { action -> Void in
                print("Follow")
                
                
                var hisid = self.post_user_id2[cell_id]
                
                var my_id = 1
                
                ////////////////////////////
                
                
                let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/\(my_id)/follow")!)
                request.HTTPMethod = "POST"
                let postString = "hisid=\(hisid)"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                    guard error == nil && data != nil else {                                                          // check for fundamental networking error
                        print(error!)
                        return
                    }
                    
                    if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
                    {
                        // pop up followed
                    }
                    
                    
                    if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                        //print("statusCode should be 201, but is \(httpStatus.statusCode)")
                        //print(response!)
                        
                        let json = JSON(data: data!)
                        let bug = json["errors"].stringValue
                        
                        if bug == "already following"
                        {
                            // pop up showing be the first to comment
                            print("already following")
                            
                        }
                        else {
                            print("try again later")
                        }
                        
                        
                        
                    }
                    
                    var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(responseString!)
                    
                    
                }
                task.resume()
                
                
                /////////////////////////////
                
            }
            actionSheetControllerIOS8.addAction(followActionButton)
            
            let shareFBActionButton: UIAlertAction = UIAlertAction(title: "Share to Facebook", style: .Default)
            { action -> Void in
                print("FB shared")
                /////////////
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                    var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    
                    fbShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.trendingTable.cellForRowAtIndexPath(indexPath) as! feed
                    
                    fbShare.addImage(cell.postedImage.image)
                    
                    self.presentViewController(fbShare, animated: true, completion: nil)
                    
                } else {
                    var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                ////////////
            }
            actionSheetControllerIOS8.addAction(shareFBActionButton)
            
            let TweetActionButton: UIAlertAction = UIAlertAction(title: "Share to Twitter", style: .Default)
            { action -> Void in
                print("Tweet")
                
                ////////////
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                    
                    var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    
                    tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.trendingTable.cellForRowAtIndexPath(indexPath) as! feed
                    
                    tweetShare.addImage(cell.postedImage.image)
                    
                    self.presentViewController(tweetShare, animated: true, completion: nil)
                    
                } else {
                    
                    var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                ///////////
            }
            actionSheetControllerIOS8.addAction(TweetActionButton)
            
            let ReportActionButton: UIAlertAction = UIAlertAction(title: "Report", style: .Destructive)
            { action -> Void in
                print("Report")
                
                self.PostId = self.post_id2[cell_id]
                
                /////////////////////////
                
                let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(self.PostId)/report")!)
                request.HTTPMethod = "POST"
                let postString = "report=1"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                    guard error == nil && data != nil else {                                                          // check for fundamental networking error
                        print(error!)
                        return
                    }
                    
                    if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print(response!)
                        
                    }
                    
                    var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                    print(responseString)
                    
                }
                task.resume()
                
                ////////////////////////////////
                
                
                
                
            }
            actionSheetControllerIOS8.addAction(ReportActionButton)
            
            self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        if self.toolBar.hidden == true {
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func search(sender: AnyObject) {
        
        self.toolBar.hidden = true
        self.navBar.hidden = true
        self.searchTable.hidden = false
        self.prefersStatusBarHidden()
        self.setNeedsStatusBarAppearanceUpdate()
        configureCustomSearchController()
        
        if trending.tag == 1 {
            
            self.trendingView.hidden = true
            self.trendingTable.hidden = true
        }
        else if followed.tag == 1 {
            
            self.followedTable.hidden = true
            self.followedView.hidden = true
        }
        else if nearby.tag == 1 {
            
            self.feedTable.hidden = true
            self.nearbyView.hidden = true
        }

    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        /*
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            
            return (countryText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
 */
    }
    
 
    
    func configureCustomSearchController() {
        CustomSearchController = customSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, searchTable.frame.size.width, 68.0), searchBarFont: UIFont(name: "Helvetica Neue", size: 15.0)!, searchBarTextColor: UIColor.whiteColor(), searchBarTintColor: UIColorFromHex(0x53D3E3,alpha: 1))
        
        CustomSearchController.CustomSearchBar.placeholder = "Search for users..."
        CustomSearchController.CustomSearchBar.preferredTextColor = UIColor.whiteColor()
        searchTable.tableHeaderView = CustomSearchController.CustomSearchBar
        
        CustomSearchController.customDelegate = self
    }
    
    func didStartSearching() {
        //shouldShowSearchResults = true
        //tblSearchResults.reloadData()
        
        searchTable.reloadData()
        
        //var query = CustomSearchController.searchBar.text
        //print(query)
    }
    
    func didTapOnSearchButton() {
        //if !shouldShowSearchResults {
          //  shouldShowSearchResults = true
            //tblSearchResults.reloadData()
        //}
        searchTable.reloadData()
    }
    
    func didTapOnCancelButton() {
        //shouldShowSearchResults = false
        //tblSearchResults.reloadData()
        
        self.toolBar.hidden = false
        self.navBar.hidden = false
        self.searchTable.hidden = true
        
        self.s_username.removeAll()
        self.s_ownertype.removeAll()
        self.s_breed.removeAll()
        self.s_userid.removeAll()
        self.s_profilepic.removeAll()
        
        searchTable.reloadData()

        //configureCustomSearchController()
        
        
        if trending.tag == 1 {
            
            self.trendingView.hidden = false
            self.trendingTable.hidden = false
        }
        else if followed.tag == 1 {
            
            self.followedTable.hidden = false
            self.followedView.hidden = false
        }
        else if nearby.tag == 1 {
            
            self.feedTable.hidden = false
            self.nearbyView.hidden = false
        }

        
    }
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        /*
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            
            return (countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
 */
        //var query = CustomSearchController.searchBar.text
        //print(query)
        //print(searchText)
        
        self.s_username.removeAll()
        self.s_ownertype.removeAll()
        self.s_breed.removeAll()
        self.s_userid.removeAll()
        self.s_profilepic.removeAll()
        
        searchTable.reloadData()
        performSearch(searchText)
        
    }
    
    func performSearch(query: String) {
        
        //var query = "anton"
        
        if query.characters.count >= 3 {
            
            print(query)
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(query)/user/search")!)
            request.HTTPMethod = "GET"
            view.showLoading()
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error!)
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 302 {           // check for http errors
                    //print("statusCode should be 302, but is \(httpStatus.statusCode)")
                    //print(response!)
                    
                    let json = JSON(data: data!)
                    let bug = json["errors"].stringValue
                    
                    if bug.containsString("No users") {
                        
                        // pop up no users by that name
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.view.hideLoading()
                    })
                }
                
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(responseString)
                
                let json = JSON(data: data!)
                
                //self.view.hideLoading()
                
                for item in json["users"].arrayValue {
                    
                    self.s_username.append(item["username"].stringValue.capitalizedString)
                    self.s_ownertype.append(item["owner_type"].stringValue.capitalizedString)
                    self.s_breed.append(item["pet_breed"].stringValue.capitalizedString)
                    self.s_userid.append(item["id"].stringValue)
                    self.s_profilepic.append(item["imageurl"].stringValue)
                    
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.searchTable.reloadData()
                        self.view.hideLoading()
                    })
                    
                }
                
                //print(self.s_username)
                //print(self.s_ownertype)
                //print(self.s_breed)
                //print(self.s_userid)
                //print(self.s_profilepic)
                
            }
            task.resume()

            
        }
        
        
    }
    
    

}