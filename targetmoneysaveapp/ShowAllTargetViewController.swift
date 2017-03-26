//
//  ShowAllTargetViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ShowAllTargetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var postDataTarget = [String]()
    
    
    var databaseRef:FIRDatabaseReference!
    private var _databaseHandle:FIRDatabaseHandle! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        _databaseHandle = ref.child("Target").child(userID!).observe(.childAdded, with: { (snapshot) in
            
            let postData = snapshot.value as? String
            if let actualPostDash = postData {
                self.postDataTarget.append(actualPostDash)
                self.tableView.reloadData()
                
            }
            
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postDataTarget.count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTargetViewCell") as! ShowTargetAllTableViewCell
        
        cell.allNameTarget.text = postDataTarget[indexPath.row]
        cell.DateTimeLbl.text = postDataTarget[indexPath.row]
        cell.priceTarget.text = postDataTarget[indexPath.row]
        
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("Target").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["NameTarger"] as? String ?? ""
            cell.allNameTarget.text = username
            
            let price = value?["Price"] as? String ?? ""
            cell.priceTarget.text = price
            
            let date = value?["Time"] as? String ?? ""
            cell.DateTimeLbl.text = date
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }


        return cell
    }

    
    
    

}
