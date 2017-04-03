//
//  CannotUnlockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/20/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CannotUnlockViewController: UIViewController {
    
    
    var refHandle: FIRDatabaseHandle?
    var refHandle2: FIRDatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (FIRAuth.auth()?.currentUser) != nil {
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            let refHandle4 = ref.child("Target").child(userID!).observe(FIRDataEventType.value, with: { (snapshot) in
                let pricev = snapshot.value as? NSDictionary
                let priceval = pricev?["Price"] as! Int
                print(priceval)

            })
            print(refHandle4)
            
            
            let refHandle5 = ref.child("MoneyCoin").observe(FIRDataEventType.value, with: { (snapshot) in
                let coinv = snapshot.value as? NSDictionary
                let coinval = coinv?["CoinBalance"] as! Int
                print(coinval)
                
            })
            
            print(refHandle5)
            
            
            if refHandle5 == refHandle4 {
//                gotoUnlock()
                gotoUnlock()
            }
            
            

        
            
        }
        

        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        

    }
    
    
    
//    func calcoingt() {
//        
//        
//        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        
//        ref.child("MoneyCoin").observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            // Get user value
//            let coinv = snapshot.value as? NSDictionary
//            let coinval = coinv?["CoinBalance"] as! Int
//            print(coinval)
//        
//        })
//        
//        ref.child("Target").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            // Get user value
//            
//            let pricev = snapshot.value as? NSDictionary
//            let priceval = pricev?["Price"] as! Int
//            print(priceval)
//            
//            
//        })
//
//
//    }
    
//    func calmoneytg() {
//        
//        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        
//        ref.child("Target").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            // Get user value
//            
//            let pricev = snapshot.value as? NSDictionary
//            let priceval = pricev?["Price"] as! Int
//            print(priceval)
//        
//            
//        })
//    
//        
//    }
//

    @IBAction func gobacktoHome(_ sender: Any) {
        
        gotoHome()
        
    }
    
    
    func gotoHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let view = storyboard.instantiateViewController(withIdentifier: "HomeUITabBarController") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view
    }
    
    func gotoUnlock() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UnlockPiggybankNav") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view
        
    }

    
    

    

}
