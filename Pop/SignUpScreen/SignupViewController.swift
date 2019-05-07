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

    let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
    profileImageView.isUserInteractionEnabled = true
    profileImageView.addGestureRecognizer(imageTap)
    profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
    profileImageView.clipsToBounds = true
    tapToChangeButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
    imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = true
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    
    }
    
    @objc func openImagePicker(_ sender:Any) {
        self.present(imagePicker, animated: true, completion: nil)
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
        guard let image = profileImageView.image else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                
              //  1. Upload image to Firebase Storage
                
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(username: username, profileImageURL: url!) { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                                
                                
                                
                                //  self.dismiss(animated: false, completion: nil)
                            } else {
                                print("Error: \(error!.localizedDescription)")
                            }
                        }
                        
                    } else {
                        //error unable to upload image
                    }
                    
                }
                    
        
            
            } else {
               
                self.resetForm()
            
                
            }
        }
    }
    
    
    func resetForm(){
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")

        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            
            if error == nil, metaData != nil {
                
                storageRef.downloadURL { url, error in
                    completion(url)
                }
            }  else {
                
                completion(nil)
            }
        }
    }
    
    
    
    
 
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
       
            ] as [String:Any]
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
        
    }
}

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImageView.image = pickedImage
            
            
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
}
