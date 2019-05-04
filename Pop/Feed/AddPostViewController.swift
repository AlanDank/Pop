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


class AddPostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var postButton: UIButton!

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
}
