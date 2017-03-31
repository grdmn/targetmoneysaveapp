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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
                let price = value?["Price"] as? String ?? ""
                self.moneyTargetLbl.text = price
                
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            ref.child("MoneyCoin").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let coin = value?["CoinBalance"] as? Int
                self.moneyTotalLbl.text = coin?.description
            
                
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
    
    
    private func setUserDataToView(withFIRUser user: FIRUser) {
        
        usernameLbl.text = user.displayName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("PasswordlogPiggybank").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild((FIRAuth.auth()?.currentUser?.uid)!){
                
                print("true rooms exist")
                
            }else{
                
                print("false room doesn't exist")
                self.gotoCreatePasswordPage()
            }
            
            
        })

        
    }
    

    func gotoLogin() {
        let HomeNav = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = HomeNav
    }
    
    func gotoCannotUnlockPage() {
        let CannotUnlockNav = self.storyboard?.instantiateViewController(withIdentifier: "CannotUnlockPageViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = CannotUnlockNav
    }

    func gotoCreatePasswordPage() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CreatePasswordPageNav") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view
        
    }

    

}
