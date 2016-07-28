import UIKit
import CoreLocation

class BasicInfoViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var owner_type: UITextField!
    @IBOutlet weak var pet_type: UITextField!
    @IBOutlet weak var breed: UITextField!
    
    var locationManager = CLLocationManager()
    var lat = Double()
    var long = Double()
    var currentLocation = CLLocation()
    
    @IBAction func done(sender: AnyObject) {
        
        var u_name = username.text
        var o_type = owner_type.text
        var p_type = pet_type.text
        var br = breed.text
        var lat = currentLocation.coordinate.latitude
        var long = currentLocation.coordinate.longitude
        var id = 1 // change to the id of the user returned while signup
        
        
        if (u_name != nil && o_type != nil) && (p_type != nil && br != nil)
        {
            let request = NSMutableURLRequest(URL: NSURL(string: "http://api.petoye.com/users/\(id)/basicinfo")!)
            request.HTTPMethod = "POST"
            let postString = "username=\(u_name)&otype=\(o_type)&ptype=\(p_type)&breed=\(br)&lat=\(lat)&lng=\(long)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print(error!)
                    return
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
        else
        {
            
            //display password doesn't match
            print("Password don't match")
            
        }

        
    }
    
    /*func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print(locations)
        var userLocation:CLLocation = locations[0]
        var lati = userLocation.coordinate.latitude
        var longi = userLocation.coordinate.longitude
        lat = lati
        long = longi
        print(lati)
        print(longi)
        
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        

        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
            
            currentLocation = locationManager.location!
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
