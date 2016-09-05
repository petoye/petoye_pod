//
//  adoptionsViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 31/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import Social

class adoptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, adoptCellDelegator {
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var a1: UIBarButtonItem!
    
    @IBOutlet weak var a2: UIBarButtonItem!
    
    var customView = UIView()
    var selectedView = UIView()
    
    @IBOutlet weak var navigBar: UINavigationBar!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var adoptionsTable: UITableView!
    
    @IBOutlet weak var post: UIButton!
    
    var username = [String]()
    var pet_info = [String]()
    var message = [String]()
    var post_user_id = [String]()
    var imageUrl = [String]()
    
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var adopt: UIImageView!
    
    @IBOutlet weak var clickbut: UIButton!
    
    var UserId = String()

    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var breed: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var des: UITextView!
    
    @IBOutlet weak var t1: UIButton!
    
    @IBOutlet weak var t2: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var popUp: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scroll.hidden = true
        
        //post.hidden = true
        
        picker.hidden = true
        
        self.hideKeyboardWhenTappedAround()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow), name: UIKeyboardDidShowNotification, object: nil)

        // Do any additional setup after loading the view.
        
        customView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height + self.navigBar.bounds.size.height, self.view.bounds.size.width / 2, 3))
        customView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(customView)
        
        selectedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 2,self.toolBar.frame.size.height + self.navigBar.bounds.size.height, self.view.bounds.size.width / 2, 3))
        selectedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.view.addSubview(selectedView)
        
        selectedView.hidden = true

        adoptions()
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    func adoptions() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/adopt/show")!)
        request.HTTPMethod = "GET"
        view.showLoading()
        
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
            //print(json["notifications"].arrayValue)
            for item in json["adoptions"].arrayValue {
                
            var str = item["pet_type"].stringValue.capitalizedString
            var str1 = item["breed"].stringValue.capitalizedString
            var str2 = item["age"].stringValue
            
            self.pet_info.append(str + "," + str1 + "- " + str2 + " years old")
            self.message.append(item["description"].stringValue)
            self.imageUrl.append(item["imageurl"].stringValue)
            self.username.append(item["user"]["username"].stringValue.capitalizedString)
            self.post_user_id.append(item["user"]["id"].stringValue)
                
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    self.adoptionsTable.reloadData()
                    self.view.hideLoading()
                    
                })
                
            }
            //print(self.username_m)
            //print(self.post_user_id)
            //print(self.imageUrl)
        }
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    @IBAction func adopt1(sender: AnyObject) {
        
        selectedView.hidden = true
        customView.hidden = false
        a1.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        a2.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        self.scroll.hidden = true
        a2.tag = 0
        a1.tag = 1
        //notifTable.reloadData()
        //messageTable.hidden = true
        //notifTable.hidden = false
        
        
        adoptionsTable.hidden = false
        
    }
    
    @IBAction func adopt2(sender: AnyObject) {
        
        customView.hidden = true
        selectedView.hidden = false
        a2.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        a1.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        self.scroll.hidden = false
        a1.tag = 0
        a2.tag = 1
        //notifTable.reloadData()
        //notifTable.hidden = true
        //messageTable.hidden = false
        
        adoptionsTable.hidden = true
        
        
        
    }
    
    
    
    @IBAction func t1(sender: AnyObject) {
        
        picker.hidden = false
        
        self.type.text = ""
        
        self.type.tag = 1
        self.breed.tag = 0
        
        pickerData = ["Dog", "Cat","Hamster","Other"]
        self.picker.delegate = self
        self.picker.dataSource = self
        
        var bottomOffset: CGPoint = CGPointMake(0, self.scroll.contentSize.height - self.scroll.bounds.size.height)
        self.scroll.setContentOffset(bottomOffset, animated: true)
        
    }
    
    
    
    @IBAction func t2(sender: AnyObject) {
        
        picker.hidden = false
        
        self.breed.text = ""
        
        self.type.tag = 0
        self.breed.tag = 1
        
        pickerData = ["Labrador", "Beagle", "Pug"]
        self.picker.delegate = self
        self.picker.dataSource = self
        
        var bottomOffset: CGPoint = CGPointMake(0, self.scroll.contentSize.height - self.scroll.bounds.size.height)
        self.scroll.setContentOffset(bottomOffset, animated: true)

    }
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        if (self.type.tag == 1) {
            
            if(row == 0)
            {
                type.text = "Dog"
            }
            else if(row == 1)
            {
                type.text = "Cat"
            }
            else if (row == 2)
            {
                type.text = "Hamster"
            }
            else if (row == 3)
            {
                type.text = "Other"
            }
            
        }
        else if (self.breed.tag == 1) {
            
            if(row == 0)
            {
                breed.text = "Labrador"
            }
            else if(row == 1)
            {
                breed.text = "Beagle"
            }
            else if (row == 2)
            {
                breed.text = "Pug"
            }
            
        }
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return username.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("adopt", forIndexPath: indexPath) as! adopt_cell
        //cell.textLabel?.text = "test"
        
        cell.delegate = self
        

        
        if imageUrl[indexPath.row].isEmpty {
            
            cell.postedImage.image = UIImage(named: "no_image.jpg")
            
            
        }
        else
        {
            
            let url = NSURL(string: imageUrl[indexPath.row])
            
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

        
        
        cell.username.text = username[indexPath.row]
        cell.pet_info.text = pet_info[indexPath.row]
        cell.profilePic.image = UIImage(named: "dawg.png")
        cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2
        cell.profilePic.clipsToBounds = true
        
        //cell.postedImage.image = UIImage(named: "no_image.jpg")
        
        cell.shareBut.tag = indexPath.row
        cell.usernamePress.tag = indexPath.row
        
        return cell
    }
    
    func share(cell_id: Int) {
        
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
                    
                    fbShare.setInitialText("Adopt this pet on PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.adoptionsTable.cellForRowAtIndexPath(indexPath) as! adopt_cell
                    
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
                    tweetShare.setInitialText("Adopt this pet on PetOye!")
                    let indexPath = NSIndexPath(forRow: cell_id, inSection: 0)
                    let cell = self.adoptionsTable.cellForRowAtIndexPath(indexPath) as! adopt_cell
                    
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
    
    func showProf(showTag: Int) {
        
        UserId = post_user_id[showTag]
        
        self.performSegueWithIdentifier("adoptToShowProfile", sender: self)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "adoptToShowProfile") {
            
            let profVC = segue.destinationViewController as! showProfileViewController
            
            profVC.uid = UserId
        }
        
    }

    func keyboardDidShow() {
        
        var bottomOffset: CGPoint = CGPointMake(0, self.scroll.contentSize.height - self.scroll.bounds.size.height)
        self.scroll.setContentOffset(bottomOffset, animated: true)
        
        //self.des.text = ""
        
        self.picker.hidden = true
        
    }
    
    @IBAction func click(sender: AnyObject) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let chooseLibActionButton: UIAlertAction = UIAlertAction(title: "Choose from camera", style: .Default)
        { action -> Void in
            print("Choose from camera")
            
            var image = UIImagePickerController()
            image.delegate = self
            //image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image.sourceType = UIImagePickerControllerSourceType.Camera
            image.allowsEditing = true
            
            self.presentViewController(image, animated: true, completion: nil)
            
        }
        actionSheetControllerIOS8.addAction(chooseLibActionButton)
        
        let chooseGalleryActionButton: UIAlertAction = UIAlertAction(title: "Choose from gallery", style: .Default)
        { action -> Void in
            //print("Choose from gallery")
            
            var image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image.allowsEditing = true
            
            self.presentViewController(image, animated: true, completion: nil)
            
        }
        actionSheetControllerIOS8.addAction(chooseGalleryActionButton)
        
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {

            self.adopt.image = image
        
            self.clickbut.hidden = true
        
            if ((type.text != nil && breed.text != nil) && (age.text != nil && des.text != nil)) && adopt.image != nil {
            
                self.post.hidden = false
            }
        
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func postBut(sender: AnyObject) {
        
        
        
        let pet_type = type.text!
        let pet_breed = breed.text!
        let pet_age = age.text!
        let description = des.text!
        
        let param = ["type" : pet_type, "breed" : pet_breed, "age" : pet_age, "description": description]
        
        self.view.showLoading()
        
        let url = NSURL(string: "http://api.petoye.com/adopt/6/createadoption")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (adopt.image == nil)
        {
            return
        }
        
        let image_data = UIImagePNGRepresentation(adopt.image!)
        
        
        if(image_data == nil)
        {
            return
        }
        
        
        let body = NSMutableData()
        
        let fname = "test.png"
        let mimetype = "image/png"
        
        //define the data post parameter
        
        
        for (key, value) in param {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition:form-data; name=\"image\"; filename=\"\(fname)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(image_data!)
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        request.HTTPBody = body
        
        
        
        let session = NSURLSession.sharedSession()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
            {
                //pop up comment added
                
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAnimate("popup_adopt")
                    
                    self.view.hideLoading()
                    
                    self.post.hidden = true
                })
                
                
                
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
                
                self.view.hideLoading()
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
            
            
            
            
        }
        task.resume()
        
        
        
    }
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().UUIDString)"
    }


    func showAnimate(image_name: String) {
        
        popUp = UIImageView(frame: CGRectMake(0, self.navigBar.frame.size.height, self.view.bounds.size.width, 53))
        
        popUp.image = UIImage(named: image_name)
        
        self.view.addSubview(popUp)
        
        
        var timer = NSTimer()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: #selector(TableViewController.removeAnimate), userInfo: nil, repeats: false)
        
        self.popUp.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.popUp.alpha = 0.0;
        
        UIImageView.animateWithDuration(0.25) {
            self.popUp.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.popUp.alpha = 1.0
        }
        
    }
    func removeAnimate() {
        
        UIImageView.animateWithDuration(0.25, animations: {
            self.popUp.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.popUp.alpha = 0.0;
            
        }) { (true) in
            self.popUp.removeFromSuperview()
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }


}
