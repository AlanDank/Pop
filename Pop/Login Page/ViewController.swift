//
//  ViewController.swift
//  Pop
//
//  Created by Alan Dang on 2/24/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//
import SwiftKeychainWrapper
import UIKit
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var emailBox: UITextField!
    
    @IBOutlet weak var passwordBox: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            self.performSegue(withIdentifier: "toFeed", sender: nil)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
       
        guard let email = emailBox.text else {return}
        guard let password = passwordBox.text else {return}
        
         Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil && user != nil {
                    print ("User Signed In")
                    self.performSegue(withIdentifier: "toFeed", sender: nil)
                    if let userID = user?.user.uid {
                        
                    }
                }
                    else {
                    print ("Error Signing In: \(error!.localizedDescription)" )
                    
                   }
                }
        
        }
    
    
    @IBAction func signupButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUpPage", sender: nil)
    }
    
    }
    


