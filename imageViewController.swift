//
//  imageViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 11/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class imageViewController: UIViewController {

    @IBOutlet weak var postedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = NSURL(string: "http://s3.amazonaws.com/petoye/feeds/images/000/000/028/medium/IMG_2623.JPG?1470837700")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil
            {
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if let image = UIImage(data: data!) {
                        
                        self.postedImage.image = image
                    }

                })
                
            }
            
            
        }
        task.resume()
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
