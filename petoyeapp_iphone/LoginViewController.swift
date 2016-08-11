import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var fb_login: UIButton!
    @IBOutlet weak var email_login: UIButton!
    @IBOutlet weak var forgot_pass: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!

    var player:AVAudioPlayer = AVAudioPlayer()
    var fbLoginSuccess = false
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil || fbLoginSuccess == true)
        {
            performSegueWithIdentifier("OldUserToHome", sender: self)
        }
    }
    
    
    @IBAction func forgot_pass(sender: AnyObject) {
        //id = NSUserDefaults.standardUserDefaults().stringForKey("id")!
        //print(id)
        //playSound()
        player.play()
        player.volume = 0.75
    }
    

    @IBAction func email_login(sender: AnyObject) {
        //player.play()
        //player.volume = 0.75
        
    
        var em = String()
        var pass = String()
        
        if email.text != nil {
            em = email.text!
        }
        if password.text != nil {
            pass = password.text!
        }
        
        if email.text != nil && password.text != nil
        {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/login")!)
        request.HTTPMethod = "POST"
        let postString = "session[email]=\(em)&session[password]=\(pass)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
            {
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("OldUserToHome", sender:self)
                }
            }

            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
            let json = JSON(data: data!)
            
            let jsonid = json["id"].stringValue
            
            self.storeId(jsonid)
            print(jsonid)
            
            
        }
        task.resume()
        }
        else {
            print("Type both email and password!")
        }
    }
    
    @IBAction func fb_login(sender: AnyObject) {
        
        player.play()
        player.volume = 0.75
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            self.performSegueWithIdentifier("OldUserToHome", sender: nil)
        }
        else
        {
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : FBSDKLoginManagerLoginResult = result
                    if(fbloginresult.grantedPermissions != nil && fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        self.fbLoginSuccess = true
                    }
                }
                
                
            }
            
        }
        
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                }
            })
        }
    }
    
    
    func keyboardDidShow() {
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        
    }



    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow), name: UIKeyboardDidShowNotification, object: nil)
        
        let audioPath = NSBundle.mainBundle().pathForResource("upvote", ofType: "wav")
        var error:NSError? = nil
        do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
        }
        catch {
            print("Something bad happened. Try catching specific errors to narrow things down")
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
