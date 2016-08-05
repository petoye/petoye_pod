//
//  notificationsViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 04/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class notificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tool: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var messages: UIBarButtonItem!
    @IBOutlet weak var notifications: UIBarButtonItem!
    
    
    var customView = UIView()
    var selectedView = UIView()
    var username = [String]()
    var notif = [String]()
    var u_id = [String]()
    var p_id = [String]()

    
    @IBOutlet weak var notifTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //toolBar.frame.size.height = 64
        
        customView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height + 20, self.view.bounds.size.width / 2, 3))
        customView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(customView)
        
        selectedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 2,self.toolBar.frame.size.height + 20, self.view.bounds.size.width / 2, 3))
        selectedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(selectedView)
        
        selectedView.hidden = true

        // Do any additional setup after loading the view.
        
        //var swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        //swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        //self.view.addGestureRecognizer(swipeUp)
        
        //var swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        //swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        //self.view.addGestureRecognizer(swipeDown)
        notifs()
    }
    
    func notifs() {
        print("called")
        
        var data = 1
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(data)/notifications")!)
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
            //print(json["notifications"].arrayValue)
            for item in (json["notifications"].arrayValue) {
                //print("new")
                //print(item.stringValue)
                var str = item.stringValue
                var str1 = str.componentsSeparatedByString("[")
                self.username.append(str1[0].capitalizedString)
                var str2 = str1[1].componentsSeparatedByString("]")
                self.u_id.append(str2[0])
                str2[1].removeAtIndex(str2[1].startIndex)
                self.notif.append(str2[1])
                if str1.count == 2{
                    print("nothing")
                    self.p_id.append("")
                }
                else if str1.count == 3{
                    var str3 = str1[2].componentsSeparatedByString("]")
                    self.p_id.append(str3[0])
                }

            }
            print(self.username)
            print(self.u_id)
            print(self.notif)
            print(self.p_id)
            
        }
        task.resume()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func message(sender: AnyObject) {
        
        customView.hidden = true
        selectedView.hidden = false
        messages.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        notifications.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        notifications.tag = 0
        messages.tag = 1
        notifTable.reloadData()
        
    }
    
    @IBAction func notifications(sender: AnyObject) {
        
        selectedView.hidden = true
        customView.hidden = false
        notifications.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        messages.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        messages.tag = 0
        notifications.tag = 1
        notifTable.reloadData()
    }

    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell{
            var cell = UITableViewCell()
            
            if notifications.tag == 1 {
            //print("in notifications")
                cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! notification_cell
                //cell.textLabel?.text = "TEST"
                
            }
            else if messages.tag == 1 {
                //print("in messages")
                cell = tableView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath)
                cell.textLabel?.text = "hola2!"
            }
            
            return cell
            
            
    }

    
    
    
    
    
    /*func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Down:
                toolBar.hidden = true
                selectedView.hidden = true
                customView.hidden = true
                
            case UISwipeGestureRecognizerDirection.Up:
                toolBar.hidden = false
                selectedView.hidden = false
                customView.hidden = false
            default:
                break
            }
            
        }
        
    }*/
    
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
