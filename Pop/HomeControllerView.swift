import UIKit
import UIkit

class HomeViewController:UIViewController {

override func viewDidLoad() {

super.viewDidLoad()

}

@IBAction func handleLogout(_ target:  ){

try!Auth.auth().signout()
self.dismiss(animated:false, completion:nil)
}
