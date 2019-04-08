//
//  Settings.swift
//  Pop
//
//  Created by Alan Dang on 4/7/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Logout(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: "uid"); do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
