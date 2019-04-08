//
//  SignUpScreen.swift
//  Pop
//
//  Created by Mason McCord on 4/4/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignUpScreen: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
      if let email = emailField.text, let password = passwordField.text{
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
  guard let strongSelf = self else { return }
  // ...}
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
