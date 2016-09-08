//
//  showPostViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 08/09/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import Social

class showPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyCustomCellDelegator {
    
    var post_user_id = [String]()
    var username = [String]()
    var message = [String]()
    var like_count = [String]()
    var comment_count = [String]()
    var post_id = [String]()
    var created_at = [String]()
    var imageurl = [String]()
    var timestamp = [String]()
    var profileUrl = [String]()
    
    var PostId = String()
    var UserId = String()
    
    var pid = String()
    
    @IBOutlet weak var feedTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getpost()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getpost() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(pid)/show")!)
        request.HTTPMethod = "GET"
        //self.view.showLoading()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.view.hideLoading()
                })
                
                
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            let json = JSON(data: data!)
            
                    self.username.append(json["user"]["username"].stringValue.capitalizedString)
                    self.profileUrl.append(json["user"]["imageurl"].stringValue)
                    self.post_id.append(json["id"].stringValue)
                    self.message.append(json["message"].stringValue)
                    self.like_count.append(json["like_count"].stringValue)
                    self.comment_count.append(json["comment_count"].stringValue)
                    self.created_at.append(json["created_at"].stringValue)
                    
                    
                    var converted = self.convert(json["created_at"].stringValue)
                    
                    self.timestamp.append(converted)
                    
                    
                    //print(date)
                    
                    
                    self.imageurl.append(json["imageurl"].stringValue)
                    ///////
                    
                    self.post_user_id.append(json["user"]["id"].stringValue)
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.feedTable.reloadData()
                        self.view.hideLoading()
                    })
                
            
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("showpost", forIndexPath: indexPath) as! feed
        //cell.textLabel?.text = "TEST"
        
        cell.delegate = self
        
        
        
        if imageurl[indexPath.row].isEmpty {
            
            dispatch_async(dispatch_get_main_queue(), {
                cell.postedImage.image = UIImage(named: "no_image.jpg")
            })
            
            
            
        }
        else
        {
            
            let url = NSURL(string: imageurl[indexPath.row])
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.postedImage.image = UIImage(named: "no_image.jpg")
                    })
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
        
        

        
        return cell
    }

    
    @IBAction func back(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func showProfile(userTag: Int) {
        
        UserId = post_user_id[userTag]
        
        self.performSegueWithIdentifier("postToShowProfile", sender: self)
    }
    
    func likedBy(byTag: Int) {
        
        PostId = post_id[byTag]
        
        self.performSegueWithIdentifier("postToLikedBy", sender: self)
        
    }
    
    func commentIt(commentTag: Int) {
        
        PostId = post_id[commentTag]
        
        UserId = post_user_id[commentTag]
        
        self.performSegueWithIdentifier("postToComment", sender: self)
        
    }
    
    func likeIt(likeTag: Int) {
        
        var likedPostId = post_id[likeTag]
        
        
        let indexPath = NSIndexPath(forRow: likeTag, inSection: 0)
        let cell = self.feedTable.cellForRowAtIndexPath(indexPath) as! feed
        
        view.showLoading()
        
        cell.likePress.viewWithTag(likeTag)?.hidden = true
        
        
        //liking a post API call
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(likedPostId)/like")!)
        request.HTTPMethod = "POST"
        let postString = "uid=1"
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
                //print(responseString)
                
                dispatch_async(dispatch_get_main_queue(), {
                    //self.feedTable.reloadData()
                    self.view.hideLoading()
                })
                
                
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                
                let json = JSON(data: data!)
                let bug = json["errors"].stringValue
                // pop up showing already liked and set image to filled
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.hideLoading()
                })
                
                
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
            //print("Tweet")
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
    
    func report(cell_id: Int) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        
                
                let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                    //print("Cancel")
                }
                actionSheetControllerIOS8.addAction(cancelActionButton)
                
                let followActionButton: UIAlertAction = UIAlertAction(title: "Follow", style: .Default)
                { action -> Void in
                    //print("Follow")
                    
                    
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
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                //self.showAnimate("popup_followed")
                            })
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
                        //print(responseString!)
                        
                        
                    }
                    task.resume()
                    
                    
                    /////////////////////////////
                    
                }
                actionSheetControllerIOS8.addAction(followActionButton)
                
                let shareFBActionButton: UIAlertAction = UIAlertAction(title: "Share to Facebook", style: .Default)
                { action -> Void in
                    //print("FB shared")
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
                    //print("Tweet")
                    
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
                    //print("Report")
                    
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
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            //self.showAnimate("popup_report")
                        })
                        
                    }
                    task.resume()
                    
                    ////////////////////////////////
                    
                    
                    
                    
                }
                actionSheetControllerIOS8.addAction(ReportActionButton)
                
                self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "postToShowProfile") {
            
            let profVC = segue.destinationViewController as! showProfileViewController
            
            profVC.uid = UserId
            
        }
        else if (segue.identifier == "postToComment") {
            
            let commentVC = segue.destinationViewController as! CommentsViewController
            
            commentVC.pid = PostId
            
        }
        else if (segue.identifier == "postToLikedBy") {
            
            let likeVC = segue.destinationViewController as! LikesViewController
            
            likeVC.pid = PostId
            
        }


        
    }


}
