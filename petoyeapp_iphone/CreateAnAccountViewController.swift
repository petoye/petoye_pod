import UIKit
import FBSDKCoreKit

class CreateAnAccountViewController: UIViewController {
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fb_signup: UIButton!
    @IBOutlet weak var email_signup: UIButton!
    
    @IBAction func email_signup(sender: AnyObject) {
        
        //getPetOye()
        
        var em = email.text!
        var pass = password.text!
        var conf = confirm.text!
        
        if (pass == conf)
        {
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/signup")!)
            request.HTTPMethod = "POST"
            let postString = "email=\(em)&password=\(pass)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error!)
                    return
                }
                
                if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 201
                {
                    dispatch_async(dispatch_get_main_queue()){
                        self.performSegueWithIdentifier("NewUserToBasicInfo", sender:self)
                    }
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
        else
        {
            
            //display password doesn't match
            print("Password don't match")
            
        }

        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
