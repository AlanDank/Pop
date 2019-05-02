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

  
    @IBOutlet weak var signupButton: UIButton!
   
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var Label: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signupButton.layer.cornerRadius = 20
        //signupButton.layer.borderWidth = 1
        //signupButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 20
        //loginButton.layer.borderWidth = 1
        //loginButton.layer.borderColor = UIColor.black.cgColor
        Label.layer.borderColor = UIColor.black.cgColor
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
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
