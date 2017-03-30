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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("PasswordlogPiggybank").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild((FIRAuth.auth()?.currentUser?.uid)!){
                
                print("true rooms exist")
                //                self.gotoCannotUnlockPage()
                
            }else{
                
                print("false room doesn't exist")
                self.gotoCreatePasswordPage()
            }
            
            
        })


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gobacktoHome(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeUITabBarController")
        present(vc, animated: true, completion: nil)

        
        
    }
    
    
    func gotoCannotUnlockPage() {
//        let CannotUnlockNav = self.storyboard?.instantiateViewController(withIdentifier: "CannotUnlockPageViewController")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = CannotUnlockNav
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CannotUnlockPageNav") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view

        
        
    }
    
    
    func gotoCreatePasswordPage() {
//        let CannotUnlockNav = self.storyboard?.instantiateViewController(withIdentifier: "CreatePasswordPageNav")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = CannotUnlockNav
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CreatePasswordPageNav") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view

        
        
    }

    
    

    

}
