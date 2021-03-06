//
//  showProfileViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/09/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import Social

class showProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, MyCustomCellDelegator {
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var p1: UIBarButtonItem!
    
    @IBOutlet weak var p2: UIBarButtonItem!
    
    @IBOutlet weak var p3: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var petInfo: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var postTable: UITableView!
    
    @IBOutlet weak var navigBar: UINavigationBar!
    
    @IBOutlet weak var follower_count: UILabel!
    
    var profileUrl:String = String()
    var headerUrl:String = String()
    
    var trendingView = UIView()
    var followedView = UIView()
    var nearbyView = UIView()
    
    var imageUrl = [String]()
    var message = [String]()
    var feed_id = [String]()
    var like_count = [String]()
    var comment_count = [String]()
    var username = [String]()
    var timestamp = [String]()
    
    var PostId = String()
    
    var field = ["Pet's name","Pet's age","Pet's type","Pet's breed","Available for breeding"]
    var info = ["Fifa","4 years old","Dog","Labrador","Yes"]
    
    var lower_info = [String]()
    
    var uid = String()
    
    
    
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var pet_info: UILabel!
    
    
    @IBOutlet weak var loading: UIButton!
    
    @IBOutlet weak var following: UIButton!
    
    @IBOutlet weak var follow: UIButton!
    
    @IBOutlet weak var city: UILabel!
    
    var profId = String()
    var profName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigBar.shadowImage = UIImage()
        navigBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.01)
        
        following.hidden = true
        
        follow.hidden = true
        
        loading.hidden = true
        
        
        
        petInfo.tableFooterView = UIView(frame: CGRectZero)
        
        self.profilePic.layer.borderWidth = 3.0
        self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePic.layer.cornerRadius = 10.0
        self.profilePic.clipsToBounds = true
        
        self.image1.layer.borderWidth = 1.0
        self.image1.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        trendingView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height - 3, self.view.bounds.size.width / 3, 3))
        trendingView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.toolBar.addSubview(trendingView)
        
        followedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 3, self.toolBar.frame.size.height - 3, self.view.bounds.size.width / 3, 3))
        followedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.toolBar.addSubview(followedView)
        followedView.hidden = true
        
        nearbyView = UIView(frame: CGRectMake(self.view.bounds.size.width * 0.66, self.toolBar.frame.size.height - 3, self.view.bounds.size.width / 3, 3))
        nearbyView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.toolBar.addSubview(nearbyView)
        nearbyView.hidden = true
        
        
        collectionView.hidden = true
        postTable.hidden = true
        
        upperprofile()
        
        
        
        
        
        
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
    
    
    @IBAction func info(sender: AnyObject) {
        
        trendingView.hidden = false
        followedView.hidden = true
        nearbyView.hidden = true
        
        p1.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        p2.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p3.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p1.tag = 1
        p2.tag = 0
        p3.tag = 0
        
        collectionView.hidden = true
        
        petInfo.hidden = false
        postTable.hidden = true
        
        //notifTable.reloadData()
        //notifTable.hidden = true
        //messageTable.hidden = false
        
        //feedTable.hidden = true
        //followedTable.hidden = true
        
    }
    
    @IBAction func pics(sender: AnyObject) {
        
        trendingView.hidden = true
        followedView.hidden = false
        nearbyView.hidden = true
        
        p2.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        p1.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p3.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p1.tag = 0
        p2.tag = 1
        p3.tag = 0
        
        petInfo.hidden = true
        
        collectionView.hidden = false
        
        postTable.hidden = true
        
        if imageUrl.count == 0 {
            
            profile()
        }
        
        
        
        //feedTable.hidden = true
        //followedTable.hidden = false
        
        /*
         if username1.count == 0 {
         
         getFollowed()
         }
         
         */
    }
    
    @IBAction func posts(sender: AnyObject) {
        
        trendingView.hidden = true
        followedView.hidden = true
        nearbyView.hidden = false
        
        p3.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        p1.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p2.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p1.tag = 0
        p2.tag = 0
        p3.tag = 1
        
        petInfo.hidden = true
        
        collectionView.hidden = true
        
        postTable.hidden = false
        
        //profile()
        
        //feedTable.hidden = false
        //followedTable.hidden = true
        
        /*
         if username.count == 0 {
         
         getNearby()
         }
         
         */
    }
    
    func checkFollowing() {
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/1/\(uid)/checkfollowing")!)
        request.HTTPMethod = "GET"
        
        //view.showLoading()
        
        loading.hidden = false
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                //self.view.hideLoading()
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                //self.view.hideLoading()
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            
            //let json = JSON(data: data!)
            
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                
                //self.view.hideLoading()
                if responseString.containsString("true") {
                    print("yes")
                    self.following.hidden = false
                    self.loading.hidden = true
                }
                else if responseString.containsString("false") {
                    print("no")
                    self.follow.hidden = false
                    self.loading.hidden = true
                }

                
            })
 
        }
        task.resume()

    }
    
    
    func upperprofile() {
        
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(uid)/showprofile")!)
        request.HTTPMethod = "GET"
        
        view.showLoading()
        
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                self.view.hideLoading()
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                self.view.hideLoading()
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            let json = JSON(data: data!)
            
            var age = json["pet_age"].stringValue + " years old"
            
            self.lower_info.append(json["pet_name"].stringValue.capitalizedString)
            self.lower_info.append(age)
            self.lower_info.append(json["pet_type"].stringValue.capitalizedString)
            self.lower_info.append(json["pet_breed"].stringValue.capitalizedString)
            self.lower_info.append(json["pet_breeding"].stringValue.capitalizedString)
            
            self.profName = json["username"].stringValue.capitalizedString
            self.profId = json["id"].stringValue
            
            self.profileUrl = json["imageurl"].stringValue
            self.headerUrl = json["headerurl"].stringValue
            
            print(json["city"].stringValue.uppercaseString)
            
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                
                self.view.hideLoading()
                
                self.checkFollowing()
                
                self.download()
                
                self.download2()
                
                self.petInfo.reloadData()
                
                self.user_name.text = json["username"].stringValue.capitalizedString
                
                self.pet_info.text = json["owner_type"].stringValue.capitalizedString + " - " + json["pet_breed"].stringValue.capitalizedString
                self.city.text = json["city"].stringValue.uppercaseString
                self.follower_count.text = json["followers"].stringValue

            })
            
            
            
        }
        task.resume()
        
    }
    
    func profile() {
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(uid)/posts")!)
        request.HTTPMethod = "GET"
        
        view.showLoading()
        
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                self.view.hideLoading()
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                self.view.hideLoading()
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            let json = JSON(data: data!)
            
            for item in json["users"].arrayValue {
                
                self.feed_id.append(item["id"].stringValue)
                self.message.append(item["message"].stringValue)
                self.like_count.append(item["like_count"].stringValue)
                self.comment_count.append(item["comment_count"].stringValue)
                //print(item["created_at"].stringValue)
                self.imageUrl.append(item["imageurl"].stringValue)
            self.timestamp.append(self.convert(item["created_at"].stringValue))
                
                self.username.append(item["user"]["username"].stringValue.capitalizedString)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    //self.followedTable.reloadData()
                    self.view.hideLoading()
                    
                    self.collectionView.reloadData()
                    self.postTable.reloadData()
                    
                })
                
            }
            
        }
        task.resume()
        
        
        
        
        
        
    }
    
    
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // 1
        // Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 2
        // Return the number of items in the section
        return imageUrl.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 3
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collect2", forIndexPath: indexPath) as! pics_cell
        
        
        
        if imageUrl[indexPath.row].isEmpty {
            
            cell.postedImage.image = UIImage(named: "no_image.jpg")
            
            
        }
        else
        {
            
            let url = NSURL(string: imageUrl[indexPath.row])
            
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
                            
                            //let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                            
                            //let cell2 = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
                            //cell2.postedImage.image = image
                        }
                        
                    })
                    
                }
                
                
            }
            task.resume()
            
            
            
        }
        
        // Configure the cell
        //cell.postedImage.image = UIImage(named: "IMG_2623.png")
        cell.postedImage.layer.borderWidth = 1.0
        cell.postedImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.postTable {
            return username.count
        }
        else {
            return lower_info.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.postTable {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("posts2", forIndexPath: indexPath) as! feed
            //cell.textLabel?.text = "TEST"
            
            cell.delegate = self
            
            
            if imageUrl[indexPath.row].isEmpty {
                
                cell.postedImage.image = UIImage(named: "no_image.jpg")
                
                
            }
            else
            {
                
                let url = NSURL(string: imageUrl[indexPath.row])
                
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
                                
                                //let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                                
                                //let cell2 = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
                                //cell2.postedImage.image = image
                            }
                            
                        })
                        
                    }
                    
                    
                }
                task.resume()
            }
            
            
            
            
            
            cell.username.text = username[indexPath.row]
            cell.message.text = message[indexPath.row]
            cell.likecount.text = like_count[indexPath.row]
            cell.commentcount.text = comment_count[indexPath.row]
            cell.timestamp.text = timestamp[indexPath.row]
            
            cell.profilePic.image = UIImage(named: "amey.jpg")
            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
            cell.profilePic.clipsToBounds = true
            
            cell.likePress.tag = indexPath.row
            cell.commentPress.tag = indexPath.row
            cell.reportPress.tag = indexPath.row
            cell.likedBy.tag = indexPath.row
            cell.share.tag = indexPath.row
            
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("info2", forIndexPath: indexPath) as! info_cell
            //cell.textLabel?.text = "TEST"
            cell.field.text = field[indexPath.row]
            cell.info.text = lower_info[indexPath.row]
            
            return cell
        }
        
    }
    
    func report(cell_id: Int) {
        
        //print(cell_id)
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let shareFBActionButton: UIAlertAction = UIAlertAction(title: "Share to Facebook", style: .Default)
        { action -> Void in
            //print("FB shared")
            
            //////////////
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                fbShare.setInitialText("Look at this super cute pet via PetOye!")
                let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                let cell = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
                
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
            //print("Tweet")
            ////////////
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                
                var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                let cell = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
                
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
    
    func likeIt(likeTag: Int) {
        //print(likeTag)
        
        
        var likedPostId = feed_id[likeTag]
        
        
        let indexPath = NSIndexPath(forRow: likeTag, inSection: 0)
        let cell = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
        //view.showLoading()
        
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
    
    func showProfile(userTag: Int) {
        
    
    }
    
    func commentIt(commentTag: Int) {
        //print(commentTag)
        
        PostId = feed_id[commentTag]
        
        self.performSegueWithIdentifier("showToComment", sender: self)
    }
    
    func likedBy(byTag: Int) {
        //print(byTag)
        
        PostId = feed_id[byTag]
        
        self.performSegueWithIdentifier("showToLikedBy", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "showToComment") {
            
            let commentVC = segue.destinationViewController as! CommentsViewController
            
            commentVC.pid = PostId
            
        }
            
        else if (segue.identifier == "showToLikedBy") {
            
            let likeVC = segue.destinationViewController as! LikesViewController
            
            likeVC.pid = PostId
            
        }
        else if (segue.identifier == "profileToMessage") {
            
            let messageController = segue.destinationViewController as! messagesViewController
            
            messageController.hisId = profId
            messageController.hisName = profName
        }

        
        
    }
    
    func shareIt(shareTag: Int) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let shareFBActionButton: UIAlertAction = UIAlertAction(title: "Share to Facebook", style: .Default)
        { action -> Void in
            //print("FB shared")
            
            //////////////
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                fbShare.setInitialText("Look at this super cute pet via PetOye!")
                let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                let cell = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
                
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
            //print("Tweet")
            ////////////
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                
                var tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetShare.setInitialText("Look at this super cute pet via PetOye!")
                let indexPath = NSIndexPath(forRow: shareTag, inSection: 0)
                let cell = self.postTable.cellForRowAtIndexPath(indexPath) as! feed
                
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
    
    
    @IBAction func back(sender: AnyObject) {
        
        
        navigationController?.popViewControllerAnimated(true)
        
        
        
    }
    
    
    @IBAction func message(sender: AnyObject) {
        
        self.performSegueWithIdentifier("profileToMessage", sender: self)
        
    }
    
    
    @IBAction func follow(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/2/follow")!)
        request.HTTPMethod = "POST"
        let postString = "hisid=\(uid)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
            {
                // show followed
                dispatch_async(dispatch_get_main_queue(), {
                    self.following.hidden = false
                    self.follow.hidden = true
                })
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
                
                let json = JSON(data: data!)
                let bug = json["errors"].stringValue
                // pop up showing already liked and set image to filled
                //self.view.hideLoading()
                
                if bug == "already following"
                {
                    // pop up showing already liked and set image to filled
                    print("already following")
                    
                    //self.view.hideLoading()

                }
                else {
                    print("try again later")
                    //self.view.hideLoading()
                }

            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print(responseString!)
            
            
            
            
        }
        task.resume()

        
        
        
        
    }
    


    func download() {
        
        if profileUrl.isEmpty {
            
            dispatch_async(dispatch_get_main_queue(), {
                self.profilePic.image = UIImage(named: "no_image.jpg")
            })
        }
        else
        {
            
            let url = NSURL(string: profileUrl)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.profilePic.image = UIImage(named: "no_image.jpg")
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if let image = UIImage(data: data!) {
                            
                            self.profilePic.image = image
                        }
                        
                    })
                    
                }
                
            }
            task.resume()
            
        }
        
        
    }
    
    
    func download2() {
        
        if headerUrl.isEmpty {
            
            dispatch_async(dispatch_get_main_queue(), {
                self.image1.image = UIImage(named: "no_image.jpg")
            })
        }
        else
        {
            
            let url = NSURL(string: headerUrl)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.image1.image = UIImage(named: "no_image.jpg")
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if let image = UIImage(data: data!) {
                            
                            self.image1.image = image
                        }
                        
                    })
                    
                }
                
            }
            task.resume()
            
        }
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
}
