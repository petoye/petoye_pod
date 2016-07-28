import UIKit

class BasicInfoViewController: UIViewController {
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var owner_type: UITextField!
    @IBOutlet weak var pet_type: UITextField!
    @IBOutlet weak var breed: UITextField!
    
    
    
    @IBAction func done(sender: AnyObject) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
