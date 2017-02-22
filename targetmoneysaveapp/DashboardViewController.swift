//
//  DashboardViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/16/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewDash: UITableView!
    @IBOutlet weak var conditionLable: UILabel!
    
   
    
    
    var refDash:FIRDatabaseReference?
    var databaseHandleDash:FIRDatabaseHandle?
    
    var postDataDash = [String]()

    
    //let rootRef = FIRDatabase.database().reference().child("Saving")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableViewDash.delegate = self
        tableViewDash.dataSource = self
        
        // Set firebase reference
        refDash = FIRDatabase.database().reference()
        
        // Retrieve the post
        databaseHandleDash = refDash?.child("Saving").observe(.childAdded, with: {(snapshot) in
            
            //Code to excute when child is add under Saving
            
            //Take the value from the snapshot and add to post data array
            
            //Try to convert the value of the data to string
            let postDash = snapshot.value as? String
            
            if let actualPostDash = postDash {
                
            // Appen the data to postDataDash array
                self.postDataDash.append(actualPostDash)
                
            // Reload the tableview
                self.tableViewDash.reloadData()
                
            }

        })

               
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        databaseHandleDash = refDash?.child("Saving").child("Save_balance").observe(.value, with: {(snapshot) in
            
            //Code to excute when child is add under Saving
            
            //Take the value from the snapshot and add to post data array
            
            //Try to convert the value of the data to string
            let weather = snapshot.value as? String
            self.conditionLable.text = weather
            
        })

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postDataDash.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celldash = tableViewDash.dequeueReusableCell(withIdentifier: "PostCellDash")
        celldash?.textLabel?.text = postDataDash[indexPath.row]
        
        return celldash!
    }
    
    
   

}
