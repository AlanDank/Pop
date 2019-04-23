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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toFeed", sender: self)
        }
    }
}
