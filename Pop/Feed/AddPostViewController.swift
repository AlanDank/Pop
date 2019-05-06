//
//  AddPostViewController.swift
//  Pop
//
//  Created by Alan Dang on 5/3/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol AddPostVCDelegate {
    func didUploadPost(withID id:String)
}

class AddPostViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!

    var delegate:AddPostVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        postButton.layer.cornerRadius = 20
        //signupButton.layer.borderWidth = 1
        //signupButton.layer.borderColor = UIColor.black.cgColor
        postButton.layer.cornerRadius = 20
        //loginButton.layer.borderWidth = 1
        //loginButton.layer.borderColor = UIColor.black.cgColor
     
    }

    @IBAction func cancelPost(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handlePostButton() {
        
        guard let userProfile = UserService.currentUserProfile else { return }
        
        
        
        let postRef = Database.database().reference().child("posts").childByAutoId()
        
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.username,
                "photoURL": userProfile.photoURL.absoluteString
                
            ],
            "text": textView.text,
            "timestamp": [".sv":"timestamp"]
        
        ] as [String:Any]
        
        postRef.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.delegate?.didUploadPost(withID: ref.key ?? <#default value#>)
                self.dismiss(animated: true, completion: nil)
            } else {
                //handle the error
            }
        })
        
        
        
    }
}
