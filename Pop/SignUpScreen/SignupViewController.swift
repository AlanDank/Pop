//
//  File.swift
//  Pop
//
//  Created by Alan Dang on 4/22/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class SignupViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UITextField!
    
    var activityView:UIActivityIndicatorView!

override func viewDidLoad() {
    
    super.viewDidLoad()
    
    

    
    }
    
    
    @IBAction func continueButton(_ sender: Any) {
        self.perform(#selector(handleSignup), with: self)

    }
    
    @objc func handleSignup() {
        
        guard let username = usernameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        self.dismiss(animated: false, completion: nil)
                    }
                    else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
            
            }
        }
    }
}
