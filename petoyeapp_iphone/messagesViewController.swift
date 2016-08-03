//
//  messagesViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 03/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class messagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var message_field: UITextField!
    
    var messageField: UITextField = UITextField()
    
    var button = UIButton(type: .Custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        message_field.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        let customView = UIView(frame: CGRectMake(0, 0, 10, 50))
        customView.backgroundColor = UIColorFromHex(0xF7F7F7,alpha: 1)
        /*
         let button = UIButton(type: .System) // let preferred over var here
         button.frame = CGRectMake(100, 100, 100, 50)
         button.backgroundColor = UIColor.greenColor()
         button.setTitle("Button", forState: UIControlState.Normal)
         button.addTarget(self, action: "Action:", forControlEvents: UIControlEvents.TouchUpInside)
         self.view.addSubview(button)
         */
        
        var button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "message.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(CommentsViewController.commentBut(_:)), forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width * 0.225) - 5 , y: 12.5, width: self.view.frame.size.width * 0.225, height: 25)
        
        
        messageField.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width * 0.225) - 5 - (self.view.frame.size.width * 0.6) - 9, y: 10, width: self.view.frame.size.width * 0.6, height: 30)
        messageField.backgroundColor = UIColor.whiteColor()
        //commentField.borderStyle = .RoundedRect
        messageField.layer.borderColor = UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).CGColor
        messageField.layer.borderWidth = 0.6
        messageField.layer.cornerRadius = 5.0
        let attributes = [
            NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 15)! // Note the !
        ]
        messageField.textAlignment = .Left
        messageField.attributedPlaceholder = NSAttributedString(string: "   Tap to add comment...", attributes:attributes)
        var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 10, messageField.frame.size.height))
        messageField.leftView = paddingView
        
        messageField.leftViewMode = .Always
        
        
        
        let messageIcon: UIImageView = UIImageView()
        messageIcon.image = UIImage(named: "messageIcon.png")
        messageIcon.frame = CGRect(x: 10, y: 17.25, width: 21, height: 15.27)
        
        
        customView.addSubview(messageField)
        
        //self.view.addSubview(commentIcon)
        customView.addSubview(messageIcon)
        
        customView.addSubview(button)
        
        
        
        message_field.inputAccessoryView = customView
        
        // downloading messages
        

    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        message_field.text = ""
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("message", forIndexPath: indexPath)
            cell.textLabel?.text = "TEST"

            
            
            return cell
    }



}
