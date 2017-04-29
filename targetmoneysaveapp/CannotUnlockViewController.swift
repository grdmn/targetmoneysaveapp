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
    
    
    var calCoin:String = ""
    var calTarget:String = ""
    
    var counter = 3
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(HomeViewController.updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    internal func updateTimer() {
        
        counter = counter - 1
        
        print(counter)
        
        if(counter > 0) {
            
            print("true loading")
            updatedata()
            
        }else {
            counter = 3
        }
        
        
    }
    
    func updatedata() {
        
        if (FIRAuth.auth()?.currentUser) != nil {
            
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("MoneyCoin").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let coinB = value?["CoinBalance"] as? Int
                self.calCoin = coinB!.description
                
                // ...
            })
            //print("cal coin" , calCoin)
            
            ref.child("Target").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let priceB = value?["Price"] as? Int
                self.calTarget = priceB!.description
                
                
                // ...
            })
            //print("cal target = " , calTarget)
            
            cal()
            
            
        } else {
            let alert = UIAlertController(title: "ผิดพลาด!", message: "ไม่มีผู้เข้าสู่ระบบ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction) in
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    
    
    func cal() {
        
        print("calcoin",calCoin)
        print("caltarget",calTarget)
        
        
        if calTarget >= calCoin{
            
            print("Equal")
            gotoUnlock()
        }else {
            print("No data")
            
        }
        
        
        
        
    }
    
    
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
        
        stopTime()
        
        
    }
    
    func stopTime() {
        timer.invalidate()
    }
    
    
    

    

}
