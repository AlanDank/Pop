//
//  UserProfile.swift
//  Pop
//
//  Created by Alan Dang on 5/3/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL: URL
    
    
    init(uid:String, username:String, photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }
}
