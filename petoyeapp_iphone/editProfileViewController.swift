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
    
    var field = ["Pet's name","Pet's age","Pet's type","Pet's breed","Available for breeding"]
    var info = ["Fifa","4 years old","Dog","Labrador","Yes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        dispatch_async(dispatch_get_main_queue()) {
            self.showAnimate("popup_prof")
            
        }
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


}
