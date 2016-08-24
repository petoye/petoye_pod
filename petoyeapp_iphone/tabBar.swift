//
//  tabBar.swift
//  PetOye
//
//  Created by Ameya Vichare on 23/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit
import XLActionController

class tabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func post() {
        
        self.performSegueWithIdentifier("post", sender: self)

    }

    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        if item.tag == 1 {
            
            //item.selectedImage = UIImage(named: "home")
            item.image = UIImage(named: "home_1")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        if item.tag == 2{
            
            item.selectedImage = UIImage(named: "users_2")
        }
        
        if item.tag == 4{
            
            item.selectedImage = UIImage(named: "notif_2")
            
        }
        
        if item.tag == 5 {
            
            item.selectedImage = UIImage(named: "my_profile2")
        }
        
        
        if item.tag == 3 {
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //print("middle")
            
            
            
            let actionController = SkypeActionController()
            
            actionController.addAction(Action("Share a post", style: .Default, handler: { action in

                    
            self.performSegueWithIdentifier("post", sender: self)
            }))
            actionController.addAction(Action("See recent adoptions", style: .Default, handler: { action in
            }))
            actionController.addAction(Action("My Profile", style: .Default, handler: { action in
            }))
            actionController.addAction(Action("Cancel", style: .Cancel, handler: { action in
                
                
            }))

            
            presentViewController(actionController, animated: true, completion: nil)
            
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
