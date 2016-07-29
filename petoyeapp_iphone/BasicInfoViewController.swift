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
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        pickerData = ["Pet Owner", "Pet Lover", "Pet Business"]
        self.picker.delegate = self
        self.picker.dataSource = self
        picker.center = CGPointMake(self.view.bounds.size.width / 2, self.view.frame.size.height/2 + 320 )
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        //print(comp)
    }
    
    @IBAction func pettype(sender: AnyObject) {
        
        picker.hidden = false
        pickerData = ["","","","Dog", "Cat", "Other"]
        self.picker.delegate = self
        self.picker.dataSource = self
        var bottomOffset: CGPoint = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
        self.scrollView.setContentOffset(bottomOffset, animated: true)
        
    }
    
    @IBAction func breedtype(sender: AnyObject) {
        picker.hidden = false
        pickerData = ["","","","","","","Labrador", "Beagle", "Pug"]
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
        if(row == 0)
        {
            owner_type.text = "Pet Owner"
        }
        else if(row == 1)
        {
            owner_type.text = "Pet Lover"
        }
        else if (row == 2)
        {
            owner_type.text = "Pet Business"
        }
        else if (row == 3)
        {
            pet_type.text = "Dog"
        }
        else if (row == 4)
        {
            pet_type.text = "Cat"
        }
        else if (row == 5)
        {
            pet_type.text = "Other"
        }
        else if (row == 6)
        {
            breed.text = "Labrador"
        }
        else if (row == 7)
        {
            breed.text = "Beagle"
        }
        else if (row == 8)
        {
            breed.text = "Pug"
        }
        
    }
 
    @IBAction func done(sender: AnyObject) {
        
        //player.play()
        //player.volume = 0.75
        
        picker.hidden = true
        var u_name = String()
        var o_type = String()
        var p_type = String()
        var br = String()
        
        if username.text != nil {
        u_name = username.text!
        }
        if owner_type.text != nil {
        o_type = owner_type.text!
        }
        if pet_type.text != nil {
        p_type = pet_type.text!
        }
        if breed.text != nil {
        br = breed.text!
        }
        var lat = locationManager.location!.coordinate.latitude
        var long = locationManager.location!.coordinate.longitude
        // change to the id of the user returned while signup
 
        /*if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized) {
            
            
            
            
        }*/
        print(lat)
        print(long)
        
            id = NSUserDefaults.standardUserDefaults().stringForKey("id")!
            print(id)
        
        if (owner_type.text != nil && username.text != nil) && (pet_type.text != nil && breed.text != nil){
        
        
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
        
        else {
            print("Select all the fields!")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
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
