//
//  editProfileViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/09/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class editProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var header: UIImageView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var head: UIButton!
    
    @IBOutlet weak var navigBar: UINavigationBar!
    
    @IBOutlet weak var prof: UIButton!
    
    var popUp: UIImageView = UIImageView()
    
    @IBOutlet weak var editTable: UITableView!
    
    var prof_pic : UIImageView = UIImageView()
    var head_pic : UIImageView = UIImageView()
    
    var username = String()
    var pet_name = String()
    var pet_age = String()
    var pet_type = String()
    var pet_breed = String()
    var pet_breeding = String()
    
    var field = ["Username","Pet's name","Pet's age","Pet's type","Pet's breed","Available for breeding"]
    var info = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.profilePic.image = prof_pic.image
        self.header.image = head_pic.image
        
        self.hideKeyboardWhenTappedAround()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow), name: UIKeyboardDidShowNotification, object: nil)
        
        
        self.profilePic.layer.borderWidth = 3.0
        self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePic.layer.cornerRadius = 10.0
        self.profilePic.clipsToBounds = true
        
        self.header.layer.borderWidth = 1.0
        self.header.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func headerSelect(sender: AnyObject) {
        
        
        head.tag = 1
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let RemoveActionButton: UIAlertAction = UIAlertAction(title: "Remove header", style: .Destructive)
        { action -> Void in
            print("Remove header")
            
            self.header.image = nil
        }
        actionSheetControllerIOS8.addAction(RemoveActionButton)
        
        let chooseLibActionButton: UIAlertAction = UIAlertAction(title: "Choose from camera", style: .Default)
        { action -> Void in
            print("Choose from camera")
            
            var image2 = UIImagePickerController()
            image2.delegate = self
            //image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image2.sourceType = UIImagePickerControllerSourceType.Camera
            image2.allowsEditing = true
            
            self.presentViewController(image2, animated: true, completion: nil)
        }
        actionSheetControllerIOS8.addAction(chooseLibActionButton)
        
        let chooseGalleryActionButton: UIAlertAction = UIAlertAction(title: "Choose from gallery", style: .Default)
        { action -> Void in
            print("Choose from gallery")
            
            var image2 = UIImagePickerController()
            image2.delegate = self
            image2.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            image2.allowsEditing = true
            
            self.presentViewController(image2, animated: true, completion: nil)
        
        }
        actionSheetControllerIOS8.addAction(chooseGalleryActionButton)
        
        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
        
    }
    
    @IBAction func profilePicSelect(sender: AnyObject) {
        
        prof.tag = 1
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController()
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let RemoveActionButton: UIAlertAction = UIAlertAction(title: "Remove profile picture", style: .Destructive)
        { action -> Void in
            print("Remove profile pic")
            
            self.profilePic.image = nil
        }
        actionSheetControllerIOS8.addAction(RemoveActionButton)
        
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
            print("Choose from gallery")
            
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
        
        print("image selected")
        
        
        if head.tag == 1{
            
            self.header.image = image
            head.tag = 0
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else if prof.tag == 1{
            
            self.profilePic.image = image
            prof.tag = 0
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
    }
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return field.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("edit", forIndexPath: indexPath) as! edit_cell
        //cell.textLabel?.text = "TEST"
        
        cell.field.text = field[indexPath.row]
        cell.info.text = info[indexPath.row]
        
        return cell
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: AnyObject) {
        
        
        let index0 = NSIndexPath(forRow: 0, inSection: 0)
        let cell0 = self.editTable.cellForRowAtIndexPath(index0) as! edit_cell
        username = cell0.info.text!
        
        let index1 = NSIndexPath(forRow: 1, inSection: 0)
        let cell1 = self.editTable.cellForRowAtIndexPath(index1) as! edit_cell
        pet_name = cell1.info.text!
        
        let index2 = NSIndexPath(forRow: 2, inSection: 0)
        let cell2 = self.editTable.cellForRowAtIndexPath(index2) as! edit_cell
        pet_age = cell2.info.text!
        
        let index3 = NSIndexPath(forRow: 3, inSection: 0)
        let cell3 = self.editTable.cellForRowAtIndexPath(index3) as! edit_cell
        pet_type = cell3.info.text!
        
        let index4 = NSIndexPath(forRow: 4, inSection: 0)
        let cell4 = self.editTable.cellForRowAtIndexPath(index4) as! edit_cell
        pet_breed = cell4.info.text!
        
        let index5 = NSIndexPath(forRow: 5, inSection: 0)
        let cell5 = self.editTable.cellForRowAtIndexPath(index5) as! edit_cell
        pet_breeding = cell5.info.text!
        
        print(username)
        print(pet_name)
        print(pet_age)
        print(pet_type)
        print(pet_breed)
        print(pet_breeding)
        
        
        
        
        UploadRequest()

    }
    
    func keyboardDidShow() {
        
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
    }
    

    func showAnimate(image_name: String) {
        
        popUp = UIImageView(frame: CGRectMake(0, self.navigBar.frame.size.height, self.view.bounds.size.width, 53))
        
        popUp.image = UIImage(named: image_name)
        
        self.view.addSubview(popUp)
        
        
        var timer = NSTimer()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(TableViewController.removeAnimate), userInfo: nil, repeats: false)
        
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
    
    func UploadRequest()
    {
        
        
        let param = ["username": username, "pname": pet_name, "page": pet_age, "type": pet_type, "breed": pet_breed, "breeding": pet_breeding]
        
        self.view.showLoading()
        
        let url = NSURL(string: "http://api.petoye.com/users/17/editprofile")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (profilePic.image == nil)
        {
            return
        }
        
        let image_data = UIImagePNGRepresentation(profilePic.image!)
        
        
        if(image_data == nil)
        {
            return
        }
        
        if (header.image == nil)
        {
            return
        }
        
        let image_data2 = UIImagePNGRepresentation(header.image!)
        
        
        if(image_data2 == nil)
        {
            return
        }

        
        
        let body = NSMutableData()
        
        let fname = "test.png"
        let fname2 = "test2.png"
        let mimetype = "image/png"
        
        //define the data post parameter
 
        
        for (key, value) in param {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData("Content-Disposition:form-data; name=\"profilepic\"; filename=\"\(fname)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(image_data!)
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
 
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData("Content-Disposition:form-data; name=\"header\"; filename=\"\(fname)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(image_data2!)
        body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        
        
        body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        
        
        request.HTTPBody = body
        
        
        
        let session = NSURLSession.sharedSession()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
            {
                //pop up comment added
                
                //self.view.hideLoading()
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAnimate("popup_prof")
                    self.view.hideLoading()
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
                
                
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                
                //self.view.hideLoading()
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.hideLoading()
                })
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



}


