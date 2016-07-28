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
