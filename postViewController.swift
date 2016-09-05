//
//  postViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 06/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import MobileCoreServices

////////////////////5

extension NSMutableData {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

class postViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var hack: UITextView!
    @IBOutlet weak var cancel: UIButton!
    
    var popUp: UIImageView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hack.becomeFirstResponder()
        
        let customView = UIView(frame: CGRectMake(0, 0, 10, 50))
        customView.backgroundColor = UIColorFromHex(0xF7F7F7,alpha: 1)
        
        
        var button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "camera_button.png"), forState: UIControlState.Normal)
        button.addTarget(self, action:#selector(postViewController.importImage(_:)), forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: 15, y: 15, width: 23, height: 20)
        
        var button1 = UIButton(type: .Custom)
        button1.setImage(UIImage(named: "post_button.png"), forState: UIControlState.Normal)
        button1.addTarget(self, action: #selector(postViewController.upload(_:)), forControlEvents: .TouchUpInside)
        button1.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width * 0.225) - 5 , y: 12.5, width: self.view.frame.size.width * 0.225, height: 25)
        
        var button2 = UIButton(type: .Custom)
        button2.setImage(UIImage(named: "gallery.png"), forState: UIControlState.Normal)
        button2.addTarget(self, action:#selector(postViewController.importGallery(_:)), forControlEvents: .TouchUpInside)
        button2.frame = CGRect(x: 53, y: 15, width: 23, height: 20)
        
        

        
        customView.addSubview(button)
        customView.addSubview(button1)
        customView.addSubview(button2)
        message.inputAccessoryView = customView
        hack.inputAccessoryView = customView
        self.hideKeyboardWhenTappedAround()
        cancel.hidden = true
        
        
        //tap
        
        //var singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTapRecognized))
        //singleTap.numberOfTapsRequired = 1
        //message.addGestureRecognizer(singleTap)
        
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        
        hack.becomeFirstResponder()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        postImage.image = nil
        cancel.hidden = true
    }
    @IBAction func back(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func upload(sender: AnyObject) {
        
        if (postImage != nil && message != nil){
            
            
            ////////////
            
            
             //let uid = 6 //userDefault.objectForKey("id")!
             //let msg = message.text!
            
            UploadRequest()
            
            
           

        }
        else {
            print("select image and type message please!")
        }
        
        
    }

    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
        hack.becomeFirstResponder()
        cancel.hidden = false
        
    }
    
    @IBAction func importImage(sender: AnyObject) {
        
        //print("okay")
        
        var image = UIImagePickerController()
        image.delegate = self
        //image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.sourceType = UIImagePickerControllerSourceType.Camera
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
    }
    
    @IBAction func importGallery(sender: AnyObject) {
        
        //print("gallery")
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }

    
    
    func UploadRequest()
    {
        
        
        
        let msg = message.text!
        //print(msg)
        
        let param = ["message" : msg]
        
        self.view.showLoading()
        
        let url = NSURL(string: "http://api.petoye.com/feeds/6/create")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (postImage.image == nil)
        {
            return
        }
        
        let image_data = UIImagePNGRepresentation(postImage.image!)
        
        
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
                
                self.view.hideLoading()
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.showAnimate("upload_popup")
                    
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        message.text = ""
        
    }
    
    func textViewDidChange(textView: UITextView) {
       
    }
    
    func showAnimate(image_name: String) {
        
        popUp = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 53))
        
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
