//
//  popViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 03/09/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class popViewController: UIViewController {
    
    var popUp: UIImageView = UIImageView()
    
    

    @IBOutlet weak var navigBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func pop(sender: AnyObject) {
        
        
        //self.showAnimate("upload_popup")
        
        
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        
        //self.popUp.removeFromSuperview()
    }
    
    
    
    
    
    
    
    
    
}
