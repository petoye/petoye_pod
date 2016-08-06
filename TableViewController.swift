//
//  TableViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

var userDefault = NSUserDefaults.standardUserDefaults()

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyCustomCellDelegator {
    
    @IBOutlet weak var feedTable: UITableView!
    @IBOutlet weak var followedTable: UITableView!
    
    var post_user_id = [String]()
    var username = [String]()
    var message = [String]()
    var like_count = [String]()
    var comment_count = [String]()
    var post_id = [String]()
    
    var post_user_id1 = [String]()
    var username1 = [String]()
    var message1 = [String]()
    var like_count1 = [String]()
    var comment_count1 = [String]()
    var post_id1 = [String]()

    
    var trendingView = UIView()
    var followedView = UIView()
    var nearbyView = UIView()

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var trending: UIBarButtonItem!
    @IBOutlet weak var followed: UIBarButtonItem!
    @IBOutlet weak var nearby: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
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
        getNearby()
        //get request for getting followed feeds
        getFollowed()
        
        feedTable.hidden = true
        followedTable.hidden = true
        
            }
    
    func getNearby() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/5/nearbyfeeds")!)
        request.HTTPMethod = "GET"
        
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
                    
                    self.post_user_id.append(item["id"].stringValue)
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.feedTable.reloadData()
                    })
                }
            }
            //print(self.username)
            //print(self.message)
            //print(self.like_count)
            //print(self.comment_count)
            //print(self.post_user_id)
            //print(self.post_id)
            
            
            //for now doing nearby feeds
        }
        task.resume()
    }
    
    func getTrending()
    {
        
    }
    
    func getFollowed()
    {
     
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/1/followedfeeds")!)
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
            
            for item in json["feeds"].arrayValue {
                self.username1.append(item["user"]["username"].stringValue.capitalizedString)
                self.post_user_id1.append(item["user"]["id"].stringValue)
                self.post_id1.append(item["id"].stringValue)
                self.message1.append(item["message"].stringValue)
                self.like_count1.append(item["like_count"].stringValue)
                self.comment_count1.append(item["comment_count"].stringValue)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.followedTable.reloadData()
                    })
                
            }
            print(self.username1)
            print(self.message1)
            print(self.like_count1)
            print(self.comment_count1)
            print(self.post_user_id1)
            print(self.post_id1)
            
            
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
        
    }
    
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var items = Int()
        if(tableView == self.followedTable) {
            items = username1.count
        }
        else {
            items = username.count
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
                
                cell.username.text = username1[indexPath.row]
                cell.postedImage.image = UIImage(named: "IMG_2623.png")
                cell.profilePic.image = UIImage(named: "dawg.png")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                
                cell.message.text = message1[indexPath.row]
                cell.likecount.text = like_count1[indexPath.row]
                cell.commentcount.text = comment_count1[indexPath.row]
                
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row

                return cell
            }
            else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("feed", forIndexPath: indexPath) as! feed
                //cell.textLabel?.text = "TEST"
                cell.delegate = self
                
                cell.postedImage.image = UIImage(named: "IMG_2623.png")
                cell.profilePic.image = UIImage(named: "dawg.png")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                
                cell.username.text = username[indexPath.row]
                
                //cell.userNameArray?.append("1")
                //print(cell.userNameArray)
                
                //storing usernames permanently for now
                //let storedUsernames = cell.username.text
                //userDefault.setObject(username, forKey: "storedPostUsername")
                userDefault.setObject(post_user_id, forKey: "storedPostUserId")
                //userDefault.setObject(message, forKey: "storedPostMessage")
                //userDefault.setObject(like_count, forKey: "storedPostLikeCount")
                //userDefault.setObject(comment_count, forKey: "storedPostCommentCount")
                userDefault.setObject(post_id, forKey: "storedPostId")
                userDefault.synchronize()
                
                cell.message.text = message[indexPath.row]
                cell.likecount.text = like_count[indexPath.row]
                cell.commentcount.text = comment_count[indexPath.row]
                
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row
                //cell.like_selected.hidden = true
                
                return cell

                
            }
            
            
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    
    func feedCell(didPressUsernameButtonInCell cell: feed) {
        //guard let indexPath = feedTable.indexPathForCell(cell) else { return }
        // Do your event-handling
        print(cell.usernamePress.tag)
        print(username[cell.usernamePress.tag])
    }
    
    func callSegueFromCell(data dataobject: AnyObject) {
        //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
        self.performSegueWithIdentifier("trendingCommentShower", sender:dataobject )
        
    }
    func callLikedBySegueFromCell(data dataobject: AnyObject) {
        //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
        self.performSegueWithIdentifier("feedToLikedBy", sender:dataobject )
        
    }
    func reloadLike() {
        self.feedTable.reloadData()
    }

}