//
//  messagesViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 03/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import JSQMessagesViewController



var messages = [JSQMessage]()
var outgoingBubbleImageView: JSQMessagesBubbleImage!
var incomingBubbleImageView: JSQMessagesBubbleImage!

class messagesViewController: JSQMessagesViewController{
    
    var hisId = String()
    var hisName = String()
    

    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hideKeyboardWhenTappedAround()
        
        self.inputToolbar.contentView.leftBarButtonItem = nil
        
        
        // take stored id from ns user defaults and store as self.senderId
        
        self.senderId = "1"
        self.senderDisplayName = hisName
        
        //title = "ChatChat"
        //navBar.title = hisName
        
        //navBar.backBarButtonItem?.image = UIImage(named: "back.png")
        
        //let backButton = UIBarButtonItem(image: UIImage(named: "back.png"), style: .Plain , target: self, action: "backbutton")
        //navigationItem.leftBarButtonItem = backButton
        
        //navigationController?.navigationBar.barTintColor =
        //UIColorFromHex(0x53D3E3,alpha: 1)
        
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //navigationController?.navigationBar.hidden = true
        
        //navigationController?.navigationController?.navigationBar.hidden = false
        //navigationController?.navigationController?.navigationBar.barTintColor =
            UIColorFromHex(0x53D3E3,alpha: 1)
        //navigationController?.navigationController?.navigationItem.title = hisName
        //navigationController?.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //navigationItem.leftBarButtonItem = backButton
        
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 414, height: 64))
        navBar.barTintColor = UIColorFromHex(0x53D3E3,alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: hisName);
        let backItem = UIBarButtonItem(image: UIImage(named: "back.png"), style: .Plain , target: self, action: "backbutton")
        navItem.leftBarButtonItem = backItem;
        navBar.setItems([navItem], animated: false);
        
 
        
        setupBubbles()
        
        //collectionView.contentOffset = CGPoint(x: 0.0, y: 64.0)
        
        collectionView.contentInset = UIEdgeInsetsMake(38, 0, 0, 0)
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        messages.removeAll()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/conversations/\(senderId)/\(hisId)/open")!)
        request.HTTPMethod = "GET"
        
        view.showLoading()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                //print("statusCode should be 201, but is \(httpStatus.statusCode)")
                //print(response!)
                
                let json = JSON(data: data!)
                let bug = json["errors"].stringValue
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.hideLoading()
                })
                
                
                
                if bug == "No messages"
                {

                    print("No messages")
                    //self.view.hideLoading()
                    
                    self.collectionView.contentInset = UIEdgeInsetsMake(38, 0, 0, 0)
                    
                }
                else {
                    print("try again later")
                    //self.view.hideLoading()
                }

                
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print(responseString)
            
            
            
            let json = JSON(data: data!)
            
            //self.addMessage(self.senderId, text: "Welcome to PetOye!")
            
            
            for item in json["conversations"].arrayValue {
                //print(item["body"].stringValue)
                //print(item["user_id"].stringValue)
                //print(item["user"]["username"].stringValue)
                self.addMessage(item["user_id"].stringValue, text: item["body"].stringValue)
                
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    
                    //self.automaticallyScrollsToMostRecentMessage = true
                    self.collectionView.reloadData()
                    self.view.hideLoading()
                })
            }
            
        }
        task.resume()
        
        
        
        
        
        
        finishReceivingMessage()
        
    }
    
    func backbutton() {
        
        print("back")
        
        navigationController?.popViewControllerAnimated(true)
        
        //print(messages.last!.text)
        
        //print(messages.last!.senderId)
        
        //NSUserDefaults.standardUserDefaults().setValue("\(messages.last!.text)", forKey: "last")
        

        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColorFromHex(0x53D3E3,alpha: 1))
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    func addMessage(id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //get the messages
        
        
        
        // messages from someone else
        //addMessage("foo", text: "Hey person!")
        // messages sent from local sender
        //addMessage(senderId, text: "Yo!")
        //addMessage(senderId, text: "I like turtles!")
        // animates the receiving of a new message on the view
        finishReceivingMessage()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.whiteColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!,
                                     senderDisplayName: String!, date: NSDate!) {
        let messageItem = [ // 2
            "text": text,
            "senderId": senderId
        ]
        
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 5
        finishSendingMessage()
        
        ///////////////////////
        var recipientId = hisId
        
        view.showLoading()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/conversations")!)
        request.HTTPMethod = "POST"
        let postString = "sender_id=\(senderId)&recipient_id=\(recipientId)&body=\(text)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
            {
                self.addMessage(senderId, text: text)
                
                dispatch_async(dispatch_get_main_queue()){
                    self.collectionView.reloadData()
                    self.view.hideLoading()
                }
                
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
                
                //pop up message sending error
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(responseString)
            
            
        }
        task.resume()
        
        
        
        
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        //print("okay")
    }
    
    
    
    
}
