//
//  editProfileViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 02/09/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class editProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var header: UIImageView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    @IBOutlet weak var head: UIButton!
    
    
    @IBOutlet weak var prof: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
    
 

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
