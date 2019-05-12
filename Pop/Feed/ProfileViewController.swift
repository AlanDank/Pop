//
//  Profile.swift
//  Pop
//
//  Created by Alan Dang on 5/12/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import Foundation
import Swift
import UIKit
import Firebase

class ProfileViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tapToChangeProfile: UIButton!
    var activityView:UIActivityIndicatorView!
    var imagePicker:UIImagePickerController!
    
    
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(imageTap)
        profilePicture.layer.cornerRadius = profilePicture.bounds.height / 2
        profilePicture.clipsToBounds = true
        tapToChangeProfile.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        
    }
    @objc func openImagePicker(_ sender:Any) {
        self.present(imagePicker, animated: true, completion: nil)
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

}

}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profilePicture.image = pickedImage
        
            
            
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
}
