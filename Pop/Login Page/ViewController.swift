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

  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signupButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignup", sender: self)
    }
    @IBAction func loginButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
}
