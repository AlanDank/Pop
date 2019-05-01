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
    @IBOutlet weak var continueOutlet: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeButton: UIButton!
    
    
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!

override func viewDidLoad() {
    
    super.viewDidLoad()
    continueOutlet.layer.cornerRadius = 20
    continueOutlet.layer.borderWidth = 1
    continueOutlet.layer.borderColor = UIColor.black.cgColor

    
    
    imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = true
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    
    
    
    
    
    
    
    
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func continueButton(_ sender: Any) {
        self.perform(#selector(handleSignup), with: self)

    }
    @IBAction func tapToChange(_ sender: Any) {
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

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
}
