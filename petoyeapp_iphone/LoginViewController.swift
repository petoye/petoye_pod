import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var fb_login: UIButton!
    @IBOutlet weak var email_login: UIButton!
    @IBOutlet weak var forgot_pass: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func forgot_pass(sender: AnyObject) {
    }
    
    @IBAction func email_login(sender: AnyObject) {
        
        var em = email.text
        var pass = password.text
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/login")!)
        request.HTTPMethod = "POST"
        let postString = "session[email]=\(em)&session[password]=\(pass)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 201 {           // check for http errors
                print("statusCode should be 201, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
            
        }
        task.resume()
    }
    
    @IBAction func fb_login(sender: AnyObject) {
        
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

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //if (FBSDKAccessToken.currentAccessToken() != nil)
        //{
            // User is already logged in, do work such as go to next view controller.
            self.performSegueWithIdentifier("OldUserToHome", sender: nil)
        //}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
