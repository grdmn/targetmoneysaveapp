//
//  HomeViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var moneyTotalLbl:UILabel!
    @IBOutlet weak var moneyTargetLbl:UILabel!
    @IBOutlet weak var usernameLbl:UILabel!
    
    var counter = 3
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkusercreatepassword()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(HomeViewController.updateTimer), userInfo: nil, repeats: true)
        
    }
    
    internal func updateTimer() {
        counter = counter - 1
        if(counter > 0) {
            print("Hey got it")
            updatedata()
        }else {
            counter = 3
        }
    }
    
    func checkusercreatepassword() {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("PasswordlogPiggybank").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild((FIRAuth.auth()?.currentUser?.uid)!){
                
                print("user have password to unlock piggybank")
                
            }else{
                
                print("user no password please send to create password")
                self.gotoCreatePasswordPage()
            }
            
            
        })
        
    }
    
    private func setUserDataToView(withFIRUser user: FIRUser) {
        
        usernameLbl.text = user.displayName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = FIRAuth.auth()?.currentUser {
            
            setUserDataToView(withFIRUser: user)
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? ""
                self.usernameLbl.text = username
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            ref.child("Target").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let price = value?["Price"] as? Int
                self.moneyTargetLbl.text = price?.description
                
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            ref.child("MoneyCoin").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let coin2 = value?["CoinBalance"] as? Int
                self.moneyTotalLbl.text = coin2?.description
                
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
            
            
            
        } else {
            let alert = UIAlertController(title: "ผิดพลาด!", message: "ไม่มีผู้เข้าสู่ระบบ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction) in
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    func updatedata() {
        
        if let user = FIRAuth.auth()?.currentUser {
            
            setUserDataToView(withFIRUser: user)
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            
            ref.child("MoneyCoin").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let coin2 = value?["CoinBalance"] as? Int
                self.moneyTotalLbl.text = coin2?.description
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
        } else {
            let alert = UIAlertController(title: "ผิดพลาด!", message: "ไม่มีผู้เข้าสู่ระบบ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction) in
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    
    func gotoLogin() {
        let HomeNav = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = HomeNav
    }
    
    func gotoCreatePasswordPage() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CreatePasswordPageNav") as UIViewController
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
