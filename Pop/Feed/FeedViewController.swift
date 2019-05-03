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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview = UITableView(frame: view.bounds, style: .plain)
        tableview.backgroundColor = UIColor.blue
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
        tableview.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut() 
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        return cell
    }
    
    
}
