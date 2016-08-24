

import UIKit

class LikesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var username = [String]()
    
    var pid = String()
    
    @IBOutlet weak var likeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeTable.tableFooterView = UIView(frame: CGRectZero)
    
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(pid)/showlike")!)
        request.HTTPMethod = "GET"
        
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
                
                if bug == "No likes yet"
                {
                    print("No likes yet")
                    
                }
                else {
                    print("try again later")
                }

            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(responseString)
            
            let json = JSON(data: data!)
            
            for item in json["feeds"].arrayValue {
                
                //print(item["username"].stringValue)
                self.username.append(item["username"].stringValue.capitalizedString)
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.likeTable.reloadData()
                })

            }
            print(self.username)
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
            cell.username.text = username[indexPath.row]
            cell.profilePic.image = UIImage(named: "dawg.png")
            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
            cell.profilePic.clipsToBounds = true

            return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}