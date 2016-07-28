import UIKit
import FBSDKCoreKit

class CreateAnAccountViewController: UIViewController {
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fb_signup: UIButton!
    @IBOutlet weak var email_signup: UIButton!
    
    @IBAction func email_signup(sender: AnyObject) {
        
        getPetOye()
        
    }
    
    
    
    
    
    func getPetOye()
    {
        
        let url = NSURL(string: "http://api.petoye.com/users/1/showprofile")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            if let urlContent = data
            {
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    print(jsonResult)
                }
                catch {
                    print("JSON failed")
                }
            }
        }
        task.resume()
        
    }
    
    
    
    func postPetOye()
    {
        
            
    }
    
    @IBAction func fb_signup(sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions != nil && fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    //print(result)
                }
                
            //self.performSegueWithIdentifier("NewUserToBasicInfo", sender: nil)
            }
            if (FBSDKAccessToken.currentAccessToken() != nil)
            {
            self.performSegueWithIdentifier("NewUserToBasicInfo", sender: nil)
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
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            //self.performSegueWithIdentifier("NewUserToBasicInfo", sender: nil)
        }
        /*
        else
        {
         let loginView : FBSDKLoginButton = FBSDKLoginButton()
         self.view.addSubview(loginView)
         loginView.center = self.view.center
         loginView.readPermissions = ["public_profile", "email", "user_friends"]
         //loginView.delegate = self
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
