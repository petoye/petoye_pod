//
//  CommentsViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 01/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, commentCellDelegator{
    
    @IBOutlet weak var commentbox: UIView!
    
    @IBOutlet weak var comment: UITextField!
    
    @IBOutlet weak var commentTable: UITableView!
    
    var commentField: UITextField = UITextField()
    
    var button = UIButton(type: .Custom)
    
    var pid = String()
    
    var uid = String()
    
    

    
    
    var userName = [String]()
    var commentMessage = [String]()
    var user_id = [String]()
    var profileUrl = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTable.tableFooterView = UIView(frame: CGRectZero)
        
        let customView = UIView(frame: CGRectMake(0, 0, 10, 50))
        customView.backgroundColor = UIColorFromHex(0xF7F7F7,alpha: 1)

        
        var button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "comment_add.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(CommentsViewController.commentBut(_:)), forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width * 0.225) - 5 , y: 12.5, width: self.view.frame.size.width * 0.225, height: 25)
        
        
        commentField.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width * 0.225) - 5 - (self.view.frame.size.width * 0.6) - 9, y: 10, width: self.view.frame.size.width * 0.6, height: 30)
        commentField.backgroundColor = UIColor.whiteColor()
        //commentField.borderStyle = .RoundedRect
        commentField.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        commentField.layer.borderWidth = 0.6
        commentField.layer.cornerRadius = 5.0
        let attributes = [
            NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 15)! // Note the !
        ]
        commentField.textAlignment = .Left
        commentField.attributedPlaceholder = NSAttributedString(string: "   Tap to add comment...", attributes:attributes)
        var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 10, commentField.frame.size.height))
        commentField.leftView = paddingView
        
        commentField.leftViewMode = .Always

        
        
        let commentIcon: UIImageView = UIImageView()
        commentIcon.image = UIImage(named: "add_comment.png")
        commentIcon.frame = CGRect(x: 10, y: 15, width: 21, height: 20)
        
        
        customView.addSubview(commentField)
        
        //self.view.addSubview(commentIcon)
        customView.addSubview(commentIcon)
        
        customView.addSubview(button)
        
        
        
        comment.inputAccessoryView = customView
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        comment.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        //downloading comments for a post
        
        //print(pid)
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(pid)/showcomment")!)
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

                if bug == "No comments yet"
                {
                    // pop up showing be the first to comment
                    print("No comments yet")
                    //self.view.hideLoading()
                }
                else {
                    print("try again later")
                    //self.view.hideLoading()
                }

            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            let json = JSON(data: data!)
            
            for item in json["comments"].arrayValue {

                self.commentMessage.append(item["comment_message"].stringValue)
                self.userName.append(item["user"]["username"].stringValue.capitalizedString)
                self.user_id.append(item["user"]["id"].stringValue)
                
                self.profileUrl.append(item["user"]["imageurl"].stringValue)
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.commentTable.reloadData()
                    self.view.hideLoading()
                })
            }

        }
        task.resume()
    }
    
    
    
    @IBAction func back(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
    
    
    
    func keyboardWillShow(notification: NSNotification) {
     
     //if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
     //self.view.frame.origin.y -= keyboardSize.height
     //self.commentbox.frame.origin.y = self.view.frame.size.height - keyboardSize.height
     //commentbox.frame = CGRect(x: 0, y: self.view.frame.size.height - keyboardSize.height, width: keyboardSize.width, height: 50)
     //}
        
        //comment.text = commentField.text
        //commentField.text = comment.text
     }
     
     func keyboardWillHide(notification: NSNotification) {
     //if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
     //self.view.frame.origin.y += keyboardSize.height
     
     //}
        comment.text = ""
     }
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func commentBut(sender: AnyObject) {
        //print(pid)
        
        
        //commentField.text = ""
        //id = NSUserDefaults.standardUserDefaults().stringForKey("id")!
        //print(id)
        
        var commentmessage = commentField.text!
        //print(commentmessage)
        
        
        comment.endEditing(true)
        
        // add a comment api call
  
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/feeds/\(pid)/comment")!)
        request.HTTPMethod = "POST"
        view.showLoading()
        
        let postString = "uid=2&comment=\(commentmessage)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
            {
                //pop up comment added
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.hideLoading()
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
                
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
                self.view.hideLoading()
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print(responseString!)
            
            
        }
        task.resume()

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return username.count
        return userName.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("comment", forIndexPath: indexPath) as! comment_cell
            //cell.textLabel?.text = "TEST"
            
            
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

            
            
            
            cell.delegate = self
            cell.comment_message.text = commentMessage[indexPath.row]
            cell.user_name.text = userName[indexPath.row]
            
            //cell.usernamePress.tag = indexpath.row
            
            //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
            //self.profileImageView.clipsToBounds = YES;
            
            cell.usernamePress.tag = indexPath.row
            
            return cell
            
    }
    

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "commentToShowProfile" {
            
            let profVC = segue.destinationViewController as! showProfileViewController
            
            profVC.uid = uid
            
        }
        
     }
    
    func showProf(showTag: Int) {
        
            uid = user_id[showTag]
        self.performSegueWithIdentifier("commentToShowProfile", sender: self)
        
        
    }
    
    
    
    
}