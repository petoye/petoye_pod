

import UIKit



class LikesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, likeCellDelegator{
    
    var username = [String]()
    var user_id = [String]()
    
    var pid = String()
    
    var uid = String()
    
    var profileUrl = [String]()
    
    
    
    
    @IBOutlet weak var likeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeTable.tableFooterView = UIView(frame: CGRectZero)
    
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(pid)/showlike")!)
        request.HTTPMethod = "GET"
        view.showLoading()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                //print("statusCode should be 200, but is \(httpStatus.statusCode)")
                //print(response!)
                
                let json = JSON(data: data!)
                let bug = json["errors"].stringValue
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.hideLoading()
                })

                if bug == "No likes yet"
                {
                    print("No likes yet")
                    //self.view.hideLoading()
                    
                }
                else {
                    print("try again later")
                    //self.view.hideLoading()
                }

            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode == 200 {
                
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                //print(responseString)
                
                let json = JSON(data: data!)
                
                for item in json["feeds"].arrayValue {
                    
                    //print(item["username"].stringValue)
                    self.username.append(item["username"].stringValue.capitalizedString)
                    self.user_id.append(item["id"].stringValue)
                    self.profileUrl.append(item["imageurl"].stringValue)
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.likeTable.reloadData()
                        self.view.hideLoading()
                    })
                    
                }
                
            }
            
            //print(self.username)
        }
        task.resume()

        
    }
    @IBAction func back(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
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
            let cell = tableView.dequeueReusableCellWithIdentifier("likes", forIndexPath: indexPath) as! like_cell
            //cell.textLabel?.text = "TEST"

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
            cell.usernamePress.tag = indexPath.row

            return cell
    }
    
    func showProf(showTag: Int) {
        
        uid = user_id[showTag]

        self.performSegueWithIdentifier("likeToShowProfile", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "likeToShowProfile" {
            
            let showProf = segue.destinationViewController as! showProfileViewController
            
            showProf.uid = uid
        }
    }


    
}