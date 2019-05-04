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
    var fetchingMore = false
    var endReached = false
    let leadingScreensForBatching:CGFloat = 2.0
    
    var cellHeights: [IndexPath: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview = UITableView(frame: view.bounds, style: .plain)
        tableview.backgroundColor = UIColor(red: 255/255, green: 122/255, blue: 215/255, alpha: 1)
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableview.register(cellNib, forCellReuseIdentifier: "postCell")
        tableview.register(LoadingCell.self, forCellReuseIdentifier: "loadingCell")
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
        
        beginBatchFetch()
        // Do any additional setup after loading the view.
    }
    
    func fetchPosts(completion: @escaping(_ posts:[Post])->()) {
        
        let postsRef = Database.database().reference().child("posts")
        var queryRef:DatabaseQuery
        let lastPost = self.posts.last

        if lastPost == nil {
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 20)
        } else {
            let lastTimestamp = lastPost!.createdAt.timeIntervalSince1970 * 1000
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryEnding(atValue: lastTimestamp).queryLimited(toLast: 20)
            
        }
  
        queryRef.observeSingleEvent(of: .value, with:  { snapshot in
            
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
                    
                    if childSnapshot.key != lastPost?.id{
                        
                        let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                        let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                        tempPosts.insert(post, at: 0)
                    }
                    
                   
                }
            }
            
            return completion(tempPosts)
            
            })
        
        
    }
    
    
    
    
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut() 
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return posts.count
        case 1:
            return fetchingMore ? 1 : 0
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0 {
          
            let cell = tableview.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
            cell.set(post: posts[indexPath.row])
          return cell
            
        } else {
            
            let cell = tableview.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
            
        }
    }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cellHeights[indexPath] = cell.frame.size.height
        }
        
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return cellHeights[indexPath] ?? 72.0
        }
        
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height * leadingScreensForBatching {
            
            if !fetchingMore && !endReached {
                beginBatchFetch()
            }
        }
    }
    func beginBatchFetch() {
        fetchingMore = true

        tableview.reloadSections(IndexSet(integer: 1), with: .fade)
        fetchPosts { newPosts in
            self.posts.append(contentsOf: newPosts)
            self.fetchingMore = false
            self.endReached = newPosts.count == 0
            UIView.performWithoutAnimation {
                self.tableview.reloadData()
            }
          
        }
    }
}
