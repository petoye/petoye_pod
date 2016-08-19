//
//  TableViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 30/07/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import Social

var userDefault = NSUserDefaults.standardUserDefaults()

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyCustomCellDelegator, UIActionSheetDelegate, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    @IBOutlet weak var feedTable: UITableView!
    @IBOutlet weak var followedTable: UITableView!
    @IBOutlet weak var searchTable: UITableView!
    
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
    
    var post_user_id1 = [String]()
    var username1 = [String]()
    var message1 = [String]()
    var like_count1 = [String]()
    var comment_count1 = [String]()
    var post_id1 = [String]()
    var created_at1 = [String]()
    var imageurl1 = [String]()
    
    var s_username = [String]()
    var s_userid = [String]()
    var s_ownertype = [String]()
    var s_breed = [String]()
    var s_location = [String]()
    var s_profilepic = [String]()





    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        //search bar
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
        getNearby()
        //get request for getting followed feeds
        getFollowed()
        
        
        feedTable.hidden = true
        followedTable.hidden = true
        searchTable.hidden = true
        
        searchTable.tableFooterView = UIView(frame: CGRectZero)
        
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
                    self.created_at.append(innerItem["created_at"].stringValue)
                    self.imageurl.append(innerItem["imageurl"].stringValue)
                    ///////
                    
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
            //print(self.created_at)
            //print(self.imageurl)
            
            
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
                self.imageurl1.append(item["imageurl"].stringValue)
                /////////
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.followedTable.reloadData()
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
        else if (tableView == self.feedTable) {
            items = username.count
        }
        else {
            items = s_username.count
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
                
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row
                cell.reportPress.tag = indexPath.row
                
                cell.profilePic.image = UIImage(named: "dawg.png")
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

                
                cell.profilePic.image = UIImage(named: "dawg.png")
                cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
                cell.profilePic.clipsToBounds = true
                
                cell.username.text = username[indexPath.row]
                
                
                userDefault.setObject(post_user_id, forKey: "storedPostUserId")
                userDefault.setObject(post_id, forKey: "storedPostId")
                userDefault.synchronize()
                
                cell.message.text = message[indexPath.row]
                cell.likecount.text = like_count[indexPath.row]
                cell.commentcount.text = comment_count[indexPath.row]
                
                
                cell.usernamePress.tag = indexPath.row
                cell.likePress.tag = indexPath.row
                cell.commentPress.tag = indexPath.row
                cell.reportPress.tag = indexPath.row
                //cell.like_selected.hidden = true
                
                return cell

                
            }
            
            else {
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
    
    func report(cell_id:Int) {
        /*
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Report", otherButtonTitles: "Follow","Share to Facebook","Share to Twitter")
        
        actionSheet.showInView(self.view)
        */
        
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
            }
            actionSheetControllerIOS8.addAction(ReportActionButton)
            
            self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
            
        }
        
        else {
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let followActionButton: UIAlertAction = UIAlertAction(title: "Follow", style: .Default)
        { action -> Void in
            print("Follow")
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
        }
        actionSheetControllerIOS8.addAction(ReportActionButton)
        
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
        }

        
    }
    
    @IBAction func search(sender: AnyObject) {
        
        self.toolBar.hidden = true
        self.navBar.hidden = true
        self.searchTable.hidden = false
        configureCustomSearchController()
        
        if trending.tag == 1 {
            
            self.trendingView.hidden = true
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
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error!)
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 302 {           // check for http errors
                    print("statusCode should be 302, but is \(httpStatus.statusCode)")
                    print(response!)
                }
                
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(responseString)
                
                let json = JSON(data: data!)
                
                
                
                for item in json["users"].arrayValue {
                    
                    self.s_username.append(item["username"].stringValue.capitalizedString)
                    self.s_ownertype.append(item["owner_type"].stringValue.capitalizedString)
                    self.s_breed.append(item["pet_breed"].stringValue.capitalizedString)
                    self.s_userid.append(item["id"].stringValue)
                    self.s_profilepic.append(item["imageurl"].stringValue)
                    
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.searchTable.reloadData()
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