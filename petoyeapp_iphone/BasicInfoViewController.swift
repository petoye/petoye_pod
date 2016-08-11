import UIKit
import CoreLocation
import AVFoundation

class BasicInfoViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var owner_type: UITextField!
    @IBOutlet weak var pet_type: UITextField!
    @IBOutlet weak var breed: UITextField!
    @IBOutlet weak var ownertype: UIButton!
    @IBOutlet weak var pettype: UIButton!
    @IBOutlet weak var breedtype: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var hi: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var password: UILabel!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var locationManager = CLLocationManager()
    var lat = Double()
    var long = Double()
    var currentLocation = CLLocation()
    var pickerData: [String] = [String]()
    var comp = Int()
    var ro = Int()
    
    @IBAction func ownertype(sender: AnyObject) {
        //self.hideKeyboardWhenTappedAround()
        picker.hidden = false
        self.ownertype.tag = 1
        self.pettype.tag = 0
        self.breedtype.tag = 0
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        pickerData = ["Pet Parent", "Pet Lover", "Pet Business"]
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.center = CGPointMake(self.view.bounds.size.width / 2, self.view.frame.size.height/2 + 320 )
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        //print(comp)
    }
    
    @IBAction func pettype(sender: AnyObject) {
        
        
        self.ownertype.tag = 0
        self.pettype.tag = 2
        self.breedtype.tag = 0
        
        picker.hidden = false
        pickerData = ["Dog", "Cat", "Other","ahh","ooh"]
        self.picker.delegate = self
        self.picker.dataSource = self
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        
    }
    
    @IBAction func breedtype(sender: AnyObject) {
        
        
        self.ownertype.tag = 0
        self.pettype.tag = 0
        self.breedtype.tag = 3
        
        picker.hidden = false
        pickerData = ["Labrador", "Beagle", "Pug"]
        self.picker.delegate = self
        self.picker.dataSource = self
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        if(self.ownertype.tag == 1) {
        
        if(row == 0)
        {
            owner_type.text = "Pet Parent"
        }
        else if(row == 1)
        {
            owner_type.text = "Pet Lover"
        }
        else if (row == 2)
        {
            owner_type.text = "Pet Business"
        }
            
        }
        else if (self.pettype.tag == 2) {
            
            if(row == 0)
            {
                pet_type.text = "Dog"
            }
            else if(row == 1)
            {
                pet_type.text = "Cat"
            }
            else if (row == 2)
            {
                pet_type.text = "Other"
            }
            else if (row == 3)
            {
                pet_type.text = "ahh"
            }

        }
        else if (self.breedtype.tag == 3) {
            
            if(row == 0)
            {
                breed.text = "Labrador"
            }
            else if(row == 1)
            {
                breed.text = "Beagle"
            }
            else if (row == 2)
            {
                breed.text = "Pug"
            }

        }

    }
 
    @IBAction func done(sender: AnyObject) {
        
        //player.play()
        //player.volume = 0.75
        
        picker.hidden = true
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            fbuser()
        }
        else
        {
            normaluser()
        }

    }
    
    func normaluser() {
        
        var u_name = username.text!
        var o_type = owner_type.text!
        var p_type = pet_type.text!
        var br = breed.text!
        
        var lat = locationManager.location!.coordinate.latitude
        var long = locationManager.location!.coordinate.longitude
        // change to the id of the user returned while signup
        
        /*if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized) {
         
         
         
         
         }*/
        print(lat)
        print(long)
        
        id = NSUserDefaults.standardUserDefaults().stringForKey("id")!
        print(id)
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(id)/basicinfo")!)
        request.HTTPMethod = "POST"
        let postString = "username=\(u_name)&otype=\(o_type)&ptype=\(p_type)&breed=\(br)&lat=\(lat)&lng=\(long)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
            {
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("NewUserToHome", sender:self)
                }
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
            
        }
        task.resume()

    }
    
    func fbuser()
    {
        
        //var email
        //var username
        
        var password = username.text! //
        var o_type = owner_type.text! //
        var p_type = pet_type.text!   //
        var br = breed.text!  //
        
        var lat = locationManager.location!.coordinate.latitude //
        var long = locationManager.location!.coordinate.longitude //
        
        var email = NSUserDefaults.standardUserDefaults().stringForKey("email")! //
        var user_name = NSUserDefaults.standardUserDefaults().stringForKey("user_name")! //
        var profilepic_url = NSUserDefaults.standardUserDefaults().stringForKey("profilepic_url")!

        print(lat)
        print(long)
        ///////////////////////
        
        print(password)
        print(o_type)
        print(p_type)
        print(br)
        print(email)
        print(user_name)
        print(profilepic_url)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/fb")!)
        request.HTTPMethod = "POST"
        let postString = "email=\(email)&password=\(password)&username=\(user_name)&otype=\(o_type)&ptype=\(p_type)&breed=\(br)&lat=\(lat)&lng=\(long)&url=\(profilepic_url)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print(error!)
                return
            }
            
            if let httpStat = response as? NSHTTPURLResponse where httpStat.statusCode == 200
            {
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("NewUserToHome", sender:self)
                }
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                
                let json = JSON(data: data!)
                
                let idjson = json["id"].stringValue
                
                self.storeId(idjson)
                print(idjson)
                
            }
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(responseString!)
            
        }
        task.resume()


        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        let audioPath = NSBundle.mainBundle().pathForResource("upvote", ofType: "wav")
        var error:NSError? = nil
        do {
            player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
        }
        catch {
            print("Something bad happened. Try catching specific errors to narrow things down")
        }
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
             var first_name = NSUserDefaults.standardUserDefaults().stringForKey("first_name")!
            self.password.text = "Password"
            self.hi.text = "Hi, \(first_name)"
        }
        else
        {
            //as it is
            self.hi.text = "Hi,"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
