//
//  slideViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 12/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class slideViewController: UIViewController {

    @IBOutlet weak var open: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        open.target = self.revealViewController()
        open.action = Selector("revealToggle:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
