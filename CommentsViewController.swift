//
//  CommentsViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 01/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var commentbox: UIView!
    
    @IBOutlet weak var comment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        comment.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        //downloading comments for a post
        
        
        
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
           
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func commentBut(sender: AnyObject) {
        print("pressed")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return username.count
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("comment", forIndexPath: indexPath) as! comment_cell
            //cell.textLabel?.text = "TEST"
            cell.comment_message.text = "amazing stuff"
            cell.user_name.text = "Messi"
            cell.profilePic.image = UIImage(named: "dawg.png")
            cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
            cell.profilePic.clipsToBounds = true
            //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
            //self.profileImageView.clipsToBounds = YES;
            
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
