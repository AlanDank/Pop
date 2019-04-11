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
    

}

@objc func handleSignUp() {
    guard let username = usernameField.text else { return }
    guard let email = emailField.text else { return }
    guard let password = passwordField.text else { return }
    
    Auth.auth().createUser(withEmail: email, password: password) { user, error in 
                                                                  
     if error == nil && user != nil {
         
         print("User Created!")
         
         let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
         changeRequest?.displayName = username
         changeRequest?.comitChanges { error in 
                                      
         if error == nil {
             
             print("User displayname changed!")
             
             
         }
                                      
                                      
                                      
     }
}
                                                                  
     else {
         
         print("Error creating user: \(error!.localizedDescription!")
         
     }
         
         
     }
                                                                  
                                                                 
                                                                 
                                                                 
                                                                 
                                                                 
                                                                 
 
                                                                 
                                                                 
                                                                 
                                                                 
                                                                 
}
