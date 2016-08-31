//
//  profileViewController.swift
//  PetOye
//
//  Created by Ameya Vichare on 26/08/16.
//  Copyright © 2016 Ameya Vichare. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var p1: UIBarButtonItem!
    
    @IBOutlet weak var p2: UIBarButtonItem!
    
    @IBOutlet weak var p3: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var trendingView = UIView()
    var followedView = UIView()
    var nearbyView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.profilePic.layer.borderWidth = 3.0
        self.profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePic.layer.cornerRadius = 10.0
        self.profilePic.clipsToBounds = true
        
        self.image1.layer.borderWidth = 1.0
        self.image1.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        trendingView = UIView(frame: CGRectMake(0,self.toolBar.frame.size.height - 3, self.view.bounds.size.width / 3, 3))
        trendingView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.toolBar.addSubview(trendingView)
        
        followedView = UIView(frame: CGRectMake(self.view.bounds.size.width / 3, self.toolBar.frame.size.height - 3, self.view.bounds.size.width / 3, 3))
        followedView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.toolBar.addSubview(followedView)
        followedView.hidden = true
        
        nearbyView = UIView(frame: CGRectMake(self.view.bounds.size.width * 0.66, self.toolBar.frame.size.height - 3, self.view.bounds.size.width / 3, 3))
        nearbyView.backgroundColor = UIColorFromHex(0x43ACB9,alpha: 1)
        self.toolBar.addSubview(nearbyView)
        nearbyView.hidden = true
        
        
        
        
        
        
        
        
        
        
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
    
    
    @IBAction func info(sender: AnyObject) {
        
        trendingView.hidden = false
        followedView.hidden = true
        nearbyView.hidden = true
        
        p1.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        p2.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p3.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p1.tag = 1
        p2.tag = 0
        p3.tag = 0
        
        //notifTable.reloadData()
        //notifTable.hidden = true
        //messageTable.hidden = false
        
        //feedTable.hidden = true
        //followedTable.hidden = true
        
    }
    
    @IBAction func pics(sender: AnyObject) {
        
        trendingView.hidden = true
        followedView.hidden = false
        nearbyView.hidden = true
        
        p2.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        p1.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p3.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p1.tag = 0
        p2.tag = 1
        p3.tag = 0
        
        //feedTable.hidden = true
        //followedTable.hidden = false
        
        /*
        if username1.count == 0 {
            
            getFollowed()
        }

        */
    }
    
    @IBAction func posts(sender: AnyObject) {
        
        trendingView.hidden = true
        followedView.hidden = true
        nearbyView.hidden = false
        
        p3.tintColor = UIColorFromHex(0x43ACB9, alpha: 1)
        p1.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p2.tintColor = UIColorFromHex(0x53D3E3, alpha: 1)
        p1.tag = 0
        p2.tag = 0
        p3.tag = 1
        
        //feedTable.hidden = false
        //followedTable.hidden = true
        
        /*
        if username.count == 0 {
            
            getNearby()
        }
 
 */
    }
    
    @IBAction func settings(sender: AnyObject) {
        
        print("settings")
        
    }
    
    
    

        
    }
    
    
    