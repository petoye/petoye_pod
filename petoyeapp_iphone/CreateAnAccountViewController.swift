import UIKit
import FBSDKCoreKit
import AVFoundation

var id = String()

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func storeId(value: String) {

        
        NSUserDefaults.standardUserDefaults().setValue("\(value)", forKey: "id")
        id = NSUserDefaults.standardUserDefaults().stringForKey("id")!
        print(id)
        
    }
    
    
    
}



class CreateAnAccountViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fb_signup: UIButton!
    @IBOutlet weak var email_signup: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var player:AVAudioPlayer = AVAudioPlayer()
    var fbLoginSuccess = false
    
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil || fbLoginSuccess == true)
        {
            performSegueWithIdentifier("NewUserToBasicInfo", sender: self)
        }
    }

    

    
    @IBAction func email_signup(sender: AnyObject) {
        //player.play()
        //player.volume = 0.75
        
        //getPetOye()
        var em = String()
        var pass = String()
        var conf = String()
        
        if email.text != nil {
        em = email.text!
        }
        if password.text != nil {
        pass = password.text!
        }
        if confirm.text != nil {
        conf = confirm.text!
        }
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
                
                var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(responseString)
                
                let json = JSON(data: data!)
                
                let idjson = json["id"].stringValue
                
                self.storeId(idjson)
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
        player.play()
        player.volume = 0.75
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions != nil && fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    //print(result)
                    self.fbLoginSuccess = true
                }
                
            //self.performSegueWithIdentifier("NewUserToBasicInfo", sender: nil)
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
