//
//  TargetPageViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/10/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TargetPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var postData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the firebase reference
        ref = FIRDatabase.database().reference()
        
        // Retrieve the post and listen for changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            // Code to excute when a child is add under "Posts"
            // Take the value from the snapshot and add it to the PostData array
            
            // Try to convert the value of the data to a string
            let post = snapshot.value as? String
            if let actualPost = post {
                
                // Appen the data to our PostData array
                self.postData.append(actualPost)
                
                // Reload in tableView
                self.tableView.reloadData()
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
        
    }

}
