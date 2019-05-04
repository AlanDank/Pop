//
//  FeedViewController.swift
//  Pop
//
//  Created by Mason McCord on 4/7/19.
//  Copyright © 2019 Alan Dang. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableview:UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview = UITableView(frame: view.bounds, style: .plain)
        tableview.backgroundColor = UIColor(red: 255/255, green: 122/255, blue: 215/255, alpha: 1)
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableview.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(tableview)
        
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *){
        layoutGuide = view.safeAreaLayoutGuide
        } else {
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableview.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.reloadData()
        
        observePosts()
        // Do any additional setup after loading the view.
    }
    
    func observePosts() {
        
        let postRef = Database.database().reference().child("posts")
        
        postRef.observe(.value, with: { snapshot in
          
            var tempPosts = [Post]()
            
            for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                        let dict = childSnapshot.value as? [String:Any],
                        let author = dict["author"] as? [String:Any],
                        let uid = author["uid"] as? String,
                        let username = author["username"] as? String,
                        let photoURL = author["photoURL"] as? String,
                        let url = URL(string:photoURL),
                        let text = dict["text"] as? String,
                        let timestamp = dict["timestamp"] as? Double {
                        
                            
                        let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                        let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                        tempPosts.append(post)
                }
            }
            
            self.posts = tempPosts
            self.tableview.reloadData()
            
        })
    }
    
    
    
    
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut() 
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
    
    
}
