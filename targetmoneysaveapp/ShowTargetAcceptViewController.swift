//
//  ShowTargetAcceptViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/26/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class ShowTargetAcceptViewController: UIViewController {
    
    @IBOutlet weak var NametargetLbl:UILabel!
    @IBOutlet weak var PriceLbl:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("Target").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["NameTarger"] as? String ?? ""
            self.NametargetLbl.text = username
            
            let price = value?["Price"] as? Int
            self.PriceLbl.text = price?.description
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    
}

