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

    @IBOutlet weak var usernameBox: UITextField!
    
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
        if let email = usernameBox.text, let password = passwordBox.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil{
                   
                    if let userID = user?.user.uid {
                    KeychainWrapper.standard.set((userID), forKey: "uid")
                    self.performSegue(withIdentifier: "toFeed", sender: nil)
                        
                     }
                   }
                }
            }
        }
    
    
    @IBAction func signupButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toStoryboard", sender: nil)
    }
    
    }
    


