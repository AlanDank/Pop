//
//  Post.swift
//  Pop
//
//  Created by Mason McCord on 5/2/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import Foundation


class Post {
    var id:String
    var author:UserProfile
    var text:String
    var createdAt:Date
    
    init(id:String, author:UserProfile, text:String, timestamp:Double) {
        self.id = id
        self.author = author
        self.text = text
        self.createdAt = Date(timeIntervalSince1970: timestamp/1000)
    }
    
    
    
}


