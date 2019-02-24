//
//  ViewController.swift
//  Pop
//
//  Created by Alan Dang on 2/24/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var usernameBox: UITextField!
    
    @IBOutlet weak var passwordBox: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func loginButton(_ sender: Any) {
        if let email = usernameBox.text, let password = passwordBox.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                guard let strongSelf = self else { return }
                if error != nil {
                    //create account
                }
                else {
                    
                }
            
            }
        }
    }
    
}

