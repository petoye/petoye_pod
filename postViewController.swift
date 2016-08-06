//
//  postViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 06/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class postViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var hack: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hack.becomeFirstResponder()
        
        let customView = UIView(frame: CGRectMake(0, 0, 10, 50))
        customView.backgroundColor = UIColorFromHex(0xF7F7F7,alpha: 1)
        
        
        var button = UIButton(type: .Custom)
        button.setImage(UIImage(named: "camera_button.png"), forState: UIControlState.Normal)
        button.addTarget(self, action:#selector(postViewController.importImage(_:)), forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: 20, y: 15, width: 23, height: 20)
        
        var button1 = UIButton(type: .Custom)
        button1.setImage(UIImage(named: "post_button.png"), forState: UIControlState.Normal)
        button1.addTarget(self, action: #selector(postViewController.upload(_:)), forControlEvents: .TouchUpInside)
        button1.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width * 0.225) - 5 , y: 12.5, width: self.view.frame.size.width * 0.225, height: 25)

        
        customView.addSubview(button)
        customView.addSubview(button1)
        message.inputAccessoryView = customView
        hack.inputAccessoryView = customView
        self.hideKeyboardWhenTappedAround()
        
        
        //tap
        
        //var singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTapRecognized))
        //singleTap.numberOfTapsRequired = 1
        //message.addGestureRecognizer(singleTap)
        
        
        

    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        postImage.image = nil
    }
    
    @IBAction func upload(sender: AnyObject) {
        
        if (postImage != nil && message != nil){
            
            
            
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
        
    }
    
    @IBAction func importImage(sender: AnyObject) {
        
        print("okay")
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
        
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
}
